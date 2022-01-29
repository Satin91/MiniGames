//
//  NetworkGameMainPagePresenter.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import RxSwift
import RxCocoa
//import AVFoundation

protocol NetworkGameMainPageViewProtocol: AnyObject {
    
    
}

protocol NetworkGameMainPagePresenterProtocol: AnyObject, ContextMenuDelegate {
    var friends: BehaviorRelay<[NetworkUser]> { get set }
    var currentUser: NetworkUser { get set }
    var currentUserObserver: Observable<NetworkUser> { get set }
    func removeFriend(indexPath: IndexPath)
    func getUsersFromCoreData()
    func goToPrivateChat(friendIndex: IndexPath)
    func backToMainViewController()
    init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol, currentUser: NetworkUser)
}


class NetworkGameMainPagePresenter: NetworkGameMainPagePresenterProtocol {
 
    
  
    
   
    
    var contextData: [ContextDataModel] = [ContextDataModel(imageName: "addUser", text: "Изменить"),
                                           ContextDataModel(imageName: "addUser", text: "Выйти")]
    
    var currentUser: NetworkUser
    var currentUserObserver: Observable<NetworkUser>
    var friends: BehaviorRelay<[NetworkUser]>
    
    //MARK: Properties
  
    weak var view: NetworkGameMainPageViewProtocol?
    var router: RouterProtocol?
    let database = Firestore.firestore()
    let nn = BehaviorRelay(value: ["","sad"])
    lazy var obsFriends = Observable.of(currentUser).asObservable()
    
    required init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol, currentUser: NetworkUser) {
        self.view = view
        self.router = router
        self.currentUser = currentUser
        self.currentUserObserver = Observable.of(currentUser).asObservable()
        self.friends = BehaviorRelay(value: [NetworkUser]())
        
        getUsersFromCoreData()
    }
    
    
    func getUsersFromCoreData() {
       
        Firebase.shared.getFriends(currentUserEmail: self.currentUser.email!) { friends in
            self.friends.accept(friends)
        }
    }
    
    func observeFriends() {
        guard let email = currentUser.email else { return }
        let path = ["users",email,"friends"].joined(separator: "/")
        
        self.database.collection(path).addSnapshotListener { list, error in
            
            
        }
 
    }
    
    func removeFriend(indexPath: IndexPath) {

        
    }
    
    func goToPrivateChat(friendIndex: IndexPath) {
        let friend = friends.value[friendIndex.row]
        router?.pushToPrivateChatViewController(currentUser: currentUser, companion: friend)
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
