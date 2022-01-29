//
//  SingleGameListPresenter.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import Foundation
import CoreData
import UIKit


protocol SingleGamePlayersViewProtocol: AnyObject {
    func addUser()
}

protocol SingleGamePlayersPresenterProtocol: AnyObject {
    var players: [SingleUserModel]? { get set}
    func saveUser(name: String, avatar: String)
    func removeUser(indexPath: IndexPath, completion: @escaping () -> Void)
    func updateUser(index: IndexPath)
    func chooseAGame()
    init(view: SingleGamePlayersViewProtocol, router: RouterProtocol)
}

class SingleGamePlayersPresenter: SingleGamePlayersPresenterProtocol {
    
    weak var view: SingleGamePlayersViewProtocol?
    var router: RouterProtocol?
    var players: [SingleUserModel]?
    
    
    //MARK: Init
    required init(view: SingleGamePlayersViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        CoreData.shared.requestUsers { result in
            switch result {
            case .success(let model):
                self.players = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeUser(indexPath: IndexPath, completion: @escaping () -> Void) {
        guard let user = players?[indexPath.row] else { return }
        CoreData.shared.removeUser(user: user)
        players?.remove(at: indexPath.row)
        completion()
    }
    
    func saveUser(name: String, avatar: String) {
        CoreData.shared.saveUser(name: name, avatar: avatar, completion: { user, isSuccess in
            guard isSuccess else { return }
            self.players?.append(user!)
        })
        self.view?.addUser()
    }
    func updateUser(index: IndexPath) {
        guard let user = players?[index.row] else { return }
        CoreData.shared.updateModel(user: user)
    }
    
    func chooseAGame() {
        router?.pushToListOfGamesViewController()
    }
    
}
