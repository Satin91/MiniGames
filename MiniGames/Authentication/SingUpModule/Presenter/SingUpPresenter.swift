//
//  SingUpPresenter.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol SingUpViewProtocol: AnyObject {
    
}

protocol SingUpPresenterProtocol: AnyObject {
    var name: String? { get set }
    var email: String? { get set }
    var password: String? { get set }
    func registerButtonPressed(name: String, email: String, password: String, avatar: String)
    init(view: SingUpViewProtocol, router: RouterProtocol)
}


class SingUpPresenter: SingUpPresenterProtocol {
    
    //MARK: Properties
    var name: String?
    var email: String?
    var password: String?
    let database = Firestore.firestore()
    
    required init(view: SingUpViewProtocol, router: RouterProtocol) {
        
    }

    
    //MARK: Action funcs
    func registerButtonPressed(name: String, email: String, password: String, avatar: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email.lowercased(), password: password.lowercased()) { [weak self] data, error in
            guard let self = self else { return }
            guard let data = data else { return }
            let object = SignUpUserModel(name: name, avatar: avatar, id: data.user.uid, email: email)
            self.database.document("users/\(email)").setData(object.userModel)
        }
    }
}


