//
//  MainPresenter.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import Foundation
import FirebaseAuth

// Методы, которые запускает MainViewController
protocol MainViewProtocol: AnyObject {
    func changeLabel(text: String)
}


protocol MainPresenterProtocol: AnyObject {
    init(mainView: MainViewProtocol, router: RouterProtocol)
    func tappedOnSingleGameButton(text: String)
    func tappedOnNetworkGame()
}

class MainPresenter: MainPresenterProtocol {
    
    weak var mainView: MainViewProtocol?
    var router: RouterProtocol?
    
    required init(mainView: MainViewProtocol, router: RouterProtocol) {
        self.mainView = mainView
        self.router = router
    }
    
    
    //MARK: Action funcs
    func tappedOnSingleGameButton(text: String) {
        router?.pushToUsersList()
    }
    func tappedOnNetworkGame() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            CoreData.shared.requestNetworkUsers { result in
                switch result {
                case .success(let users):
                    let currentUser = users.filter({$0.currentUser == true}).first
                        self.router?.pushToNetworkGameMainPage(currentUser: currentUser!)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            router?.pushToLoginViewController()
        }
    }
}
