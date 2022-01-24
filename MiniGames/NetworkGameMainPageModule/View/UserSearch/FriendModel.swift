//
//  FriendModel.swift
//  MiniGames
//
//  Created by Артур on 22.01.22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FriendModel {
    
    var friend: [String: String] = [:]
    let currentUser = FirebaseAuth.Auth.auth().currentUser
    let database = Firestore.firestore()
    
    init(chatID: String, email: String) {
        let id = UUID().uuidString
        self.friend["chatID"] = id
        self.friend["email"] = email
    }
    
    func checkFriendExistance(searchEmail: String) {
        self.database.collection(["users",currentUser!.email!,"friends"].joined(separator: "/")).getDocuments { snap, error in
            let exist = snap?.documents.contains(where: { doc in
                doc.documentID == searchEmail
            })
            self.addFriend(isExist: exist, searchEmail: searchEmail)
        }
    }
    
    func addFriend(isExist: Bool?, searchEmail: String) {
        guard let isExist = isExist else { return }
        
        switch isExist {
        case true:
            print("Есть такой друг")
            
            break
        case false:
            
            print("Нет такого друга")
            self.database.collection(["users",currentUser!.email!,"friends"].joined(separator: "/")).document(searchEmail).setData(self.friend)
            
            //add friend to searching user
            self.database.collection(["users",searchEmail,"friends"].joined(separator: "/")).document(currentUser!.email!).setData(self.friend)
            
        }
        
    }
}
