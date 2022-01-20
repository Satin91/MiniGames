//
//  NetworkGameMainPagePresenter.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import CloudKit

protocol NetworkGameMainPageViewProtocol: AnyObject {
    func addUser()
    func fillTheData()
}

protocol NetworkGameMainPagePresenterProtocol: AnyObject {
    var friends: [NetworkUserModel]? { get set}
    var avatar: String? { get set }
    var name: String? { get set }
    func goToPrivateChat(friendIndex: IndexPath)
    init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol)
}

class NetworkGameMainPagePresenter: NetworkGameMainPagePresenterProtocol {
   
    
    
    //MARK: Properties
    var avatar: String?
    var name: String?
    var friends: [NetworkUserModel]?
    var view: NetworkGameMainPageViewProtocol?
    var router: RouterProtocol?
    
    private let fetchCurrentUser = FirebaseAuth.Auth.auth().currentUser
    private var currentUser: NetworkUserModel?
    required init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        fillTheDataOnView()
    }
    
    func fillTheDataOnView() {
        Firebase.shared.getUser(email: fetchCurrentUser!.email!) { user in
            self.avatar = user.avatar
            self.name = user.name
            self.currentUser = user
        }
        
        Firebase.shared.getFriends(completion: { friends in
            self.friends = friends
            self.view?.fillTheData()
        })
    }
    
    func goToPrivateChat(friendIndex: IndexPath) {
        guard let friend = friends?[friendIndex.row] else { return }
        router?.pushToPrivateChatViewController(currentUser: currentUser!, companion: friend)
    }
}
