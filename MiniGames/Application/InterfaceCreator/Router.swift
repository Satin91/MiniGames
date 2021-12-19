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
    func pushToSingleGame()
    // Дальше установить переходы на другие контроллеры
}


//MARK: Навигация
class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    
    //MARK: SingleGame
    func pushToSingleGame() {
        guard let navigationController = navigationController else { return }
        guard let singleGameList = moduleBuilder?.createSingleGameListModule(router: self) else { return }
        navigationController.pushViewController(singleGameList, animated: true)
    }
    
    
    //MARK: InitialViewController
    func initialViewController() {
        guard let navigationController = navigationController else { return }
        guard let mainView = moduleBuilder?.createMainModule(router: self) else { return }
        navigationController.viewControllers = [mainView]
    }
    
}
