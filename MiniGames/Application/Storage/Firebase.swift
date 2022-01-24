//
//  Firebase.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class Firebase {
    
    private let database = Firestore.firestore()
    private let realtimeDatabase = Database.database().reference()
    static let shared = Firebase()
    
    func userPath(_ email: String) -> String {
        return "/users/\(email)"
    }
    
    func userCollectionFriendsPath(_ email: String) -> String {
        
        return "users/\(email)/friends"
    }
    let concurrentQueue = DispatchQueue(label: "ru.denisegaluev.concurrent-queue", attributes: .concurrent)
  
    func getFriends(currentUserEmail: String, completion: @escaping  ([NetworkUser]) -> Void) {
        self.database.collection("users/\(currentUserEmail.lowercased())/friends/").getDocuments { snapshot, error in
            let documents = snapshot?.documents
            var friends = [NetworkUser]()
            documents?.forEach({ [weak self] snapshot in
                guard let self = self else { return }
                let data = snapshot.data() as! [String: String]
                self.getUser(email: snapshot.documentID, currentUser: false, chatID: data["chatID"], lastMessage: data["lastMessage"]!) { friend in
                    friends.append(friend)
                    if friends.count == documents?.count {
                        completion(friends)
                    }
                }
            })
        }
    }
    
    func getLastMessage(chatID: String, completion: @escaping (String) -> Void ) {
        
        let path = "chats/\(chatID)/messages"
        //Получение последнего сообщения с помощью queryLimited
        self.realtimeDatabase.child(path).queryLimited(toLast: 1).getData { error, data in
            guard let dict = data.value as? [String:[String:String]] else {
                completion("Нет сообщений")
                return }
            for i in dict.values {
                completion(i["text"]!)
            }
        }
        
            

    }
    func getDictionaryUser(email: String, completion: @escaping ([String:String]) -> Void ) {
        
        guard let currentUser = FirebaseAuth.Auth.auth().currentUser else { return }
        
        if email == currentUser.email {
            self.database.document("users/\(email.lowercased())").getDocument { snapshot, error in
                guard let data = snapshot?.data() as? [String: String] else { return }
                completion(data)
            }
        } else {
            self.database.collection(userCollectionFriendsPath(currentUser.email!)).document(email).getDocument { [weak self] doc, error in
                guard let data = doc?.data() as? [String:String] else { return }
                
                self?.database.document("users/\(email.lowercased())").getDocument { snapshot, error in
                    
                    guard var user = snapshot?.data() as? [String: String] else { return }
                    
                    user["chatID"] = data["chatID"]
                    self?.getLastMessage(chatID: data["chatID"]!) { text in
                       
                        user["lastMessage"] = text
                        completion(user)
                    }
                }
            }
        }
    }
    
    
    
    
    
    //Получение одного пользователя
    func getUser(email: String,currentUser: Bool = false, chatID: String? = "", lastMessage: String = "", completion: @escaping (NetworkUser) -> Void ){
        
        self.database.document("users/\(email.lowercased())").getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: String] else { return }
            let object = NetworkUser(context: CoreData.shared.context)
            object.name = data["name"]!
            object.avatar = data["avatar"]!
            object.id = data["id"]!
            object.lastMessage = lastMessage == "" ? "История пустая" : lastMessage
            object.email = email
            object.chatID = chatID
            object.currentUser = currentUser
            completion(object)
        }
    }
    
}



