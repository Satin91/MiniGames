//
//  Presenter.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit

protocol ListOfGamesViewProtocol: AnyObject {
    
}
protocol ListOfGamesPresenterProtocol: AnyObject {
    func selectGame(indexPath: IndexPath)
    init(view: ListOfGamesViewProtocol, router: RouterProtocol)
}

class ListOfGamesPresenter: ListOfGamesPresenterProtocol {
  
    
    private var router: RouterProtocol?
    weak var view: ListOfGamesViewProtocol?
    
    required init(view: ListOfGamesViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router

    }
    func selectGame(indexPath: IndexPath) {
        router?.pushToGameViewController(game: RandomNumberViewController())
    }
    
}

