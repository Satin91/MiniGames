//
//  GamePresenter.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation

protocol GameViewProtocol: AnyObject {
    var playerResult: PlayersGameModel? { get set }
    func moveCollectionView(toIndex: IndexPath)
    func addGameToChildView(game: inout GameProtocol, presenter: GamePresenterProtocol)
}

protocol GamePresenterProtocol: AnyObject {
    init(view: GameViewProtocol, router: RouterProtocol, game: GameProtocol?)
    func sendGameToView(game: inout GameProtocol?)
    func presentGame()
    func getPlayers()
    var players: [SingleUserModel]? { get set }
    func getResult(score: Double)
    func passNextPlayer()
}


class GamePresenter: GamePresenterProtocol {
    
    // MARK: Properties
    weak var view: GameViewProtocol?
    var players: [SingleUserModel]?
    var router: RouterProtocol?
    var game: GameProtocol?
    var currentPlayerIndex: Int = 0
    private var resultsInTheGame: [PlayersGameModel] = []
    
    
    // MARK: Init
    required init(view: GameViewProtocol, router: RouterProtocol, game: GameProtocol?) {
        self.view = view
        self.router = router
        self.game = game
        getPlayers()
        createModels()
    }
    
    
    // MARK: Public funcs:
    func presentGame() {
        sendGameToView(game: &game)
    }
    
    func sendGameToView(game: inout GameProtocol?) {
        guard var game = game else { return }
        view?.addGameToChildView(game: &game, presenter: self)
    }
    
    func passNextPlayer() {
        guard currentPlayerIndex < players!.count - 1 else {
            view?.moveCollectionView(toIndex: IndexPath(row: 0, section: 0) )
            currentPlayerIndex = 0
            return }
        view?.moveCollectionView(toIndex: IndexPath(row: currentPlayerIndex + 1, section: 0))
        currentPlayerIndex += 1
    }
    
    
    // MARK: Private funcs
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
    
    func createModels() {
        for i in players! {
            resultsInTheGame.append(PlayersGameModel(name: i.name!, score: 0))
        }
    }
    
    
    // MARK: Delegate funcs
    func getResult(score: Double) {
        passNextPlayer()
        resultsInTheGame[currentPlayerIndex].score += score
        print(resultsInTheGame)
    }
}
