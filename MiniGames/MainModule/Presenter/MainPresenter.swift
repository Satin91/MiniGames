//
//  MainPresenter.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import Foundation

// Методы, которые запускает MainViewController
protocol MainViewProtocol: AnyObject {
    func changeLabel(text: String)
}


protocol MainPresenterProtocol: AnyObject {
    init(mainView: MainViewProtocol, router: RouterProtocol)
    func tappedOnButton(text: String)
}

class MainPresenter: MainPresenterProtocol {
   
    weak var mainView: MainViewProtocol?
    var router: RouterProtocol?
    
    required init(mainView: MainViewProtocol, router: RouterProtocol) {
        self.mainView = mainView
        self.router = router
    }
    
    
    //MARK: Output
    func tappedOnButton(text: String) {
        router?.pushToUsersList()
    }
    
}
