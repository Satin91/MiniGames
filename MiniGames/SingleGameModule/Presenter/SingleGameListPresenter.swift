//
//  SingleGameListPresenter.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import Foundation
import CoreData
import UIKit


protocol SingleGameListViewProtocol: AnyObject {
    func addUser()
}

protocol SingleGameListPresenterProtocol: AnyObject {
    var model: [SingleUserModel]? { get set}
    func getUser(name: String)
    init(view: SingleGameListViewProtocol, router: RouterProtocol)
}

class SingleGameListPresenter: SingleGameListPresenterProtocol {
    
    weak var view: SingleGameListViewProtocol?
    var router: RouterProtocol?
    var model: [SingleUserModel]?
    
    required init(view: SingleGameListViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        CoreData.shared.requestCoreDataModel { result in
            switch result {
            case .success(let model):
                self.model = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUser(name: String) {
        CoreData.shared.saveModel(name: name) { model in
            guard let model = model else { return }
            self.model?.append(model)
        }
        view?.addUser()
    }
    
    
    
    
    
}
