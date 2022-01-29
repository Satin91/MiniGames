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
    var statusText: Dynamic<String> { get set }
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
    var statusText = Dynamic("")
    var block: Bool = false
    
    required init(view: LoginViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
    //MARK: Action funcs
    func enterLoginAndPass(login: String, password: String) {
        
        guard login != "", password != "" else { self.statusText.value = "Заполните данные" ;return }
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if error != nil {
                self.statusText.value = error!.localizedDescription
            } else {
                //Блокировка вызова метода в случае неоднократного нажатия кнопки
                if self.block == false {
                    self.saveUserAndPushToNextVC()
                }
                self.block = true
            }
        }
       
    }
    
    func saveUserAndPushToNextVC() {
            Firebase.shared.getUser(email: FirebaseAuth.Auth.auth().currentUser!.email!,currentUser: true) { [weak self] user in
                CoreData.shared.saveNetworkUser(user: user) { user, bs in
                    self?.router?.pushToNetworkGameMainPage(currentUser: user!)
                }
            }
        }
    
    func singUpButtonPressed() {
        router?.showSingUpViewController()
    }
}
