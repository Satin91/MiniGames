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
import AVFoundation

protocol NetworkGameMainPageViewProtocol: AnyObject {
    
    
}

protocol NetworkGameMainPagePresenterProtocol: AnyObject, ContextMenuDelegate {
    var friends: Dynamic<[NetworkUser]> { get set}
    var currentUser: Dynamic<NetworkUser> { get set }
    func getUsersFromCoreData()
    func goToPrivateChat(friendIndex: IndexPath)
    func backToMainViewController()
    init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol)
}


class NetworkGameMainPagePresenter: NetworkGameMainPagePresenterProtocol {
   
    var contextData: [ContextDataModel] = [ContextDataModel(imageName: "addUser", text: "Изменить"),
                                           ContextDataModel(imageName: "addUser", text: "Выйти")]
 
    var currentUser: Dynamic<NetworkUser> = Dynamic(NetworkUser())
    
    //MARK: Properties
    var friends: Dynamic<[NetworkUser]> = Dynamic([NetworkUser]())
    weak var view: NetworkGameMainPageViewProtocol?
    var router: RouterProtocol?

    required init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
     func getUsersFromCoreData() {
         
        CoreData.shared.requestNetworkUsers { result in
            switch result {
            case .success(let model):
                self.currentUser.value = model.filter({$0.currentUser == true}).first!
                self.friends.value = model.filter({$0.currentUser == false})
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goToPrivateChat(friendIndex: IndexPath) {
        let friend = friends.value[friendIndex.row]
        router?.pushToPrivateChatViewController(currentUser: currentUser.value, companion: friend)
    }
    
    func backToMainViewController() {
        router?.backToMainViewController()
    }
    
    func didTappedContextCell(index: IndexPath) {
        switch index.row {
        case 0:
            break
            //edit profile
        case 1:
            try! FirebaseAuth.Auth.auth().signOut()
            CoreData.shared.removeAllUsers()
            router?.backToMainViewController()
        default:
            break
        }
    }
}
