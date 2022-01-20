//
//  LoginPresenter.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import FirebaseAuth


protocol LoginViewProtocol: AnyObject {
    
}

protocol LoginPresenterProtocol: AnyObject {
    var login: String? { get set }
    var password: String? { get set }
    func singUpButtonPressed()
    func enterLoginAndPass(login: String, password: String)
    init(view: LoginViewProtocol, router: RouterProtocol)
}

class LoginPresenter: LoginPresenterProtocol {
    
    //MARK: Properties
    var login: String?
    var password: String?
    weak var view: LoginViewProtocol?
    var router: RouterProtocol?
    
   
    
    required init(view: LoginViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
    //MARK: Action funcs
    func enterLoginAndPass(login: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if error != nil {
                print("Пользователь не найден")
        }
    }
    }

    func singUpButtonPressed() {
        router?.showSingUpViewController()
    }
    
    
    //MARK: Private funcs
    
}
