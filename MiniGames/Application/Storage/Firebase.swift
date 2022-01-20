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
    private let currentUser = FirebaseAuth.Auth.auth().currentUser
    static let shared = Firebase()
    
    func getFriends(completion: @escaping ([NetworkUserModel]) -> Void) {
        
        var friends = [NetworkUserModel]()
        guard let currentUser = self.currentUser else { return }
        database.collection("users/\(currentUser.email!.lowercased())/friends/").getDocuments { snapshot, error in
            let documents = snapshot?.documents
            
            documents?.forEach({ [weak self] snapshot in
                guard let self = self else { return }
                self.getUser(email: snapshot.documentID) { friend in
                    friends.append(friend)
                    if friends.count == documents?.count {
                        completion(friends)
                    }
                }
            })
        }
    }
    
    func getUser(email: String, completion: @escaping (NetworkUserModel) -> Void ){
        
        self.database.document("users/\(email.lowercased())").getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: String] else { return }
            let object = NetworkUserModel(name: data["name"]!, avatar: data["avatar"]!, id: data["id"]!, email: email)
            completion(object)
        }
    }
}
