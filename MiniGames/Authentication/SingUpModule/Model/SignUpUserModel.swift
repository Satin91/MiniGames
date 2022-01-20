//
//  SignUpUserModel.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation

class SignUpUserModel {
    
    //MARK: Properties
    var userModel: [String:Any] = [:]
    
    
    //MARK: Init
    init(name: String,avatar: String,id: String, email: String) {
        userModel["name"] = name
        userModel["avatar"] = avatar
        userModel["id"] = id
        userModel["email"] = email
    }
}
