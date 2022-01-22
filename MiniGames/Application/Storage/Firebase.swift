//
//  Firebase.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class Firebase {
    
    private let database = Firestore.firestore()
    static let shared = Firebase()
    
    
    //Получение пользователя и его друзей
    func getAndSaveUserData(currentUserEmail: String ,completion: @escaping () -> Void) {
        
        let concurrentQueue = DispatchQueue(label: "ru.denisegaluev.concurrent-queue", attributes: .concurrent)
        let group = DispatchGroup()
        
        concurrentQueue.async {
            group.enter()
            self.database.collection("users/\(currentUserEmail.lowercased())/friends/").getDocuments { snapshot, error in
                let documents = snapshot?.documents
                
                var counter = 0
                documents?.forEach({ [weak self] snapshot in
                    guard let self = self else { return }
                    let chatID = snapshot.data() as! [String: String]
                    self.getUser(email: snapshot.documentID, currentUser: false, chatID: chatID["chatID"]) { friend in
                        CoreData.shared.saveNetworkUser(user: friend, currentUser: false) { user, asd in
                            print("Выполнено 1")
                            counter += 1
                            if counter == documents?.count {
                                group.leave()
                            }
                            
                        }
                    }
                })
            }
            
            group.enter()
            self.database.document("users/\(currentUserEmail.lowercased())").getDocument { document, error in
                let doc = document?.documentID
                self.getUser(email: doc!, currentUser: true) { user in
                    CoreData.shared.saveNetworkUser(user: user, currentUser: true) { user2, asd in
                        print("Выполнено 2")
                        group.leave()
                    }
                }
            }
            
            group.wait()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
    // Получение одного пользователя
    func getUser(email: String,currentUser: Bool = false, chatID: String? = "", completion: @escaping (NetworkUser) -> Void ){
        self.database.document("users/\(email.lowercased())").getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: String] else { return }
            let object = NetworkUser(context: CoreData.shared.context)
            object.name = data["name"]!
            object.avatar = data["avatar"]!
            object.id = data["id"]!
            object.email = email
            object.chatID = chatID
            object.currentUser = currentUser
            print("Firebase object is \(object)")
            completion(object)
        }
    }
}
