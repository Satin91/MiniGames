//
//  Router.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

protocol RouterStandart {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}
protocol RouterProtocol: RouterStandart {
    func initialViewController() // Начальный контроллер
    func pushToLoginViewController()
    func showSingUpViewController()
    func pushToNetworkGameMainPage()
    func pushToPrivateChatViewController(currentUser: NetworkUserModel, companion: NetworkUserModel)
    func pushToUsersList()
    func pushToListOfGamesViewController()
    func pushToGameViewController(game: GameProtocol)
    // Дальше установить переходы на другие контроллеры
}


//MARK: Навигация
class Router: RouterProtocol {
   
    
  
    //MARK: Properties
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    
    //MARK: init
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    
    //MARK: InitialViewController
    func initialViewController() {
        guard let navigationController = navigationController else { return }
        guard let mainView = moduleBuilder?.createMainModule(router: self) else { return }
        navigationController.viewControllers = [mainView]
    }
 
    //MARK: Login
    func pushToLoginViewController() {
        guard let navigationController = navigationController else { return }
        guard let loginViewController = moduleBuilder?.createLoginModule(router: self) else { return }
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    
    //MARK: SingUp
    func showSingUpViewController() {
        guard let navigationController = navigationController else { return }
        guard let singUpViewController = moduleBuilder?.createSingUpModule(router: self) else { return }
        navigationController.pushViewController(singUpViewController, animated: true)
    }
    
    
    
    //MARK: Network game main page
    func pushToNetworkGameMainPage() {
        guard let navigationController = navigationController else { return }
        guard let networkGameMainPage = moduleBuilder?.createNetworkGameMainPageModule(router: self) else { return }
        navigationController.pushViewController(networkGameMainPage, animated: true)
    }
    
    
    //MARK: Private chat
    func pushToPrivateChatViewController(currentUser: NetworkUserModel, companion: NetworkUserModel) {
        guard let navigationController = navigationController else { return }
        guard let privateChat = moduleBuilder?.createPrivateChatModule(router: self, currentUser: currentUser, companion: companion) else { return }
        navigationController.pushViewController(privateChat, animated: true)
        
    }
    
    //MARK: UserList
    func pushToUsersList() {
        guard let navigationController = navigationController else { return }
        guard let singleGameList = moduleBuilder?.createSingleGameUsersModule(router: self) else { return }
        navigationController.pushViewController(singleGameList, animated: true)
    }
    
    
    //MARK: GamesList
    func pushToListOfGamesViewController() {
        guard let navigationController = navigationController else { return }
        guard let listOfGamesViewController = moduleBuilder?.createListOfGamesModule(router: self) else { return }
        navigationController.pushViewController(listOfGamesViewController, animated: true)
    }
    
    
    //MARK: Game
    func pushToGameViewController(game: GameProtocol) {
        guard let navigationController = navigationController else { return }
        guard let gameViewController = moduleBuilder?.createGameModule(router: self, game: game) else { return }
        navigationController.pushViewController(gameViewController, animated: true)
    }
    
}
