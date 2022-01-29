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
}
