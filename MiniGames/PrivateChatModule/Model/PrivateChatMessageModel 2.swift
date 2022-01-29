//
//  PrivateChatMessageModel.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import Foundation

class PrivateChatMessageModel {
    
    var message: [String: String] = [:]
    
    init(name: String,text: String,id: String, date: String, email: String) {
        message["name"]  = name
        message["text"]  = text
        message["id"]    = id
        message["date"]  = date
        message["email"] = email
        
    }
}
