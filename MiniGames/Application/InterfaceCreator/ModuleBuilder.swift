//
//  ModuleBuilder.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

protocol ModuleBuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UIViewController
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createNetworkGameMainPageModule(router: RouterProtocol) -> UIViewController
    func createPrivateChatModule(router: RouterProtocol, currentUser: NetworkUserModel, companion: NetworkUserModel) -> UIViewController
    func createSingleGameUsersModule(router: RouterProtocol) -> UIViewController
    func createListOfGamesModule(router: RouterProtocol) -> UIViewController
    func createGameModule(router: RouterProtocol, game: GameProtocol) -> UIViewController
    func createSingUpModule(router: RouterProtocol) -> UIViewController
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
    
    
    //MARK: Login
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    //MARK: SingUp
    func createSingUpModule(router: RouterProtocol) -> UIViewController {
        let view = SingUpViewController()
        let presenter = SingUpPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    //MARK: Network game main page
    func createNetworkGameMainPageModule(router: RouterProtocol) -> UIViewController {
        let view = NetworkGameMainPageViewController()
        let presenter = NetworkGameMainPagePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
    //MARK: Private chat
    func createPrivateChatModule(router: RouterProtocol, currentUser: NetworkUserModel, companion: NetworkUserModel) -> UIViewController {
        let view = PrivateChatViewController()
        let presenter = PrivateChatPresenter(view: view, router: router, currentUser: currentUser, companion: companion)
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
