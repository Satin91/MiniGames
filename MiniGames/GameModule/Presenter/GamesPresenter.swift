//
//  GamePresenter.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation

protocol GameViewProtocol: AnyObject {
    func addGameToChildView(game: GameProtocol)
}

protocol GamePresenterProtocol: AnyObject {
    init(view: GameViewProtocol, router: RouterProtocol, game: GameProtocol?)
    func sendGameToView(game: GameProtocol?)
    func presentGame()
    func getPlayers()
    var players: [SingleUserModel]? { get set }
}


class GamePresenter: GamePresenterProtocol {
   
    
    
    
    var players: [SingleUserModel]?
    
    var router: RouterProtocol?
    var view: GameViewProtocol?
    var game: GameProtocol?
    
    required init(view: GameViewProtocol, router: RouterProtocol, game: GameProtocol?) {
        self.view = view
        self.router = router
        self.game = game
        getPlayers()
    }
    
    func presentGame() {
        sendGameToView(game: game)
    }
    
    func getPlayers() {
        CoreData.shared.requestUsers { result in
            switch result {
            case .success(let players):
                self.players = players
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendGameToView(game: GameProtocol?) {
        guard let game = game else { return }
        view?.addGameToChildView(game: game)
    }
}
