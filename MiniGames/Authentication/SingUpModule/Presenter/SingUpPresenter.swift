//
//  SingUpPresenter.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

protocol SingUpViewProtocol: AnyObject {
    
}

protocol SingUpPresenterProtocol: AnyObject {
    var name: String? { get set }
    var email: String? { get set }
    var password: String? { get set }
    func registerButtonPressed(name: String, email: String, password: String, avatar: String)
    func registerWithGoogle(avatar: String)
    init(view: SingUpViewProtocol, router: RouterProtocol)
}


class SingUpPresenter: SingUpPresenterProtocol {
    
    //MARK: Properties
    var name: String?
    var email: String?
    var password: String?
    let database = Firestore.firestore()
    var view: SingUpViewProtocol!
    var router: RouterProtocol!
    required init(view: SingUpViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
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
    
    func registerWithGoogle(avatar: String) {
        GIDSignIn.sharedInstance.signIn(with: GoogleSignInManager.signInConfig, presenting: self.view as! UIViewController) { user, error in
            guard error == nil else { return }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                let object = SignUpUserModel(name: (user?.profile!.name)!, avatar: avatar, id: FirebaseAuth.Auth.auth().currentUser!.uid, email: user!.profile!.email)
                self.database.document("users/\(user!.profile!.email)").setData(object.userModel)
                Firebase.shared.getUser(email: FirebaseAuth.Auth.auth().currentUser!.email!,currentUser: true) { [weak self] user in
                    CoreData.shared.saveNetworkUser(user: user) { user, bs in
                        self!.router.pushToNetworkGameMainPage(currentUser: user!)
                    }
                }
            }
            
        }
    }
}


