//
//  ModuleBuilder.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

protocol ModuleBuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSingleGameListModule(router: RouterProtocol) -> UIViewController
}
//MARK: Сборщик контроллеров
class ModuleBuilder: ModuleBuilderProtocol {
   
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(mainView: view, router: router)
        view.presenter = presenter
        return view
    }
   
    func createSingleGameListModule(router: RouterProtocol) -> UIViewController {
        let view = SingleGameListViewController()
        let presenter = SingleGameListPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
}
