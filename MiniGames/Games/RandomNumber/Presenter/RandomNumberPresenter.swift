//
//  RandomNumberPresenter.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation

class RandomNumberPresenter {
    
    func players() -> [SingleUserModel] {
        var user = SingleUserModel()
        user.name = "Carl"
        let users = [user]
        return users
    }
}
