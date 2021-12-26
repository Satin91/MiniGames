//
//  ModuleBuilder.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

protocol ModuleBuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSingleGameUsersModule(router: RouterProtocol) -> UIViewController
    func createListOfGamesModule(router: RouterProtocol) -> UIViewController
    func createGameModule(router: RouterProtocol, game: GameProtocol) -> UIViewController
}
//MARK: Сборщик контроллеров
class ModuleBuilder: ModuleBuilderProtocol {

    
   //MARK: MainModule
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(mainView: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    //MARK: SingleGame users
    func createSingleGameUsersModule(router: RouterProtocol) -> UIViewController {
        let view = SingleGameUsersViewController()
        let presenter = SingleGamePlayersPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    //MARK: ListOfGames
    func createListOfGamesModule(router: RouterProtocol) -> UIViewController {
        let view = ListOfGamesViewController()
        let presenter = ListOfGamesPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    //MARK: Game
    func createGameModule(router: RouterProtocol, game: GameProtocol) -> UIViewController {
        let view = GameViewController()
        let presenter = GamePresenter(view: view, router: router, game: game)
        view.presenter = presenter
        return view
    }

}
