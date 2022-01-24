//
//  NetworkGameMainPagePresenter.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
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
    func goToPrivateChat(companion: NetworkUser)
    func backToMainViewController()
    init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol, currentUser: NetworkUser)
}


class NetworkGameMainPagePresenter: NetworkGameMainPagePresenterProtocol {
    
    var contextData: [ContextDataModel] = [ContextDataModel(imageName: "addUser", text: "Изменить"),
                                           ContextDataModel(imageName: "addUser", text: "Выйти")]
    
    var currentUser: NetworkUser
    var currentUserObserver: Observable<NetworkUser>
    var friends: BehaviorRelay<[NetworkUser]>
    let realtimeDatabase = Database.database().reference()
    //MARK: Properties
    
    weak var view: NetworkGameMainPageViewProtocol?
    var router: RouterProtocol?
    let database = Firestore.firestore()
    
    required init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol, currentUser: NetworkUser) {
        self.view = view
        self.router = router
        self.currentUser = currentUser
        self.currentUserObserver = Observable.of(currentUser).asObservable()
        self.friends = BehaviorRelay(value: [NetworkUser]())
        
        getFriends()
        observeFriends()
        observeMessages()
    }
    
    
    private func getFriends() {
        CoreData.shared.requestNetworkUsers { result in
            switch result{
            case .success(let users):
                self.friends.accept(users.filter({$0.currentUser == false}))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    func observeMessages() {
        
        database.collection(Firebase.shared.userCollectionFriendsPath(currentUser.email!)).addSnapshotListener { snap, error in
            self.updateUsers(email: self.currentUser.email!)
        }
        
        for i in friends.value {
            database.collection(Firebase.shared.userCollectionFriendsPath(i.email!)).addSnapshotListener { snap, error in
                self.updateUsers(email: i.email!)
            }
            
            self.realtimeDatabase.child("chats/\(i.chatID!)/messages").observe(.childAdded) { [weak self] snapshot in
                print("CHAT ADD")
                self?.updateUsers(email: i.email!)
            }
        }
    }
    
    func observeFriends() {
        let path = Firebase.shared.userCollectionFriendsPath(currentUser.email!)
        self.database.collection(path).getDocuments { data, _ in
            let friendsEmail = (data?.documents.map({$0.documentID}))!
            friendsEmail.forEach({ email in
                self.updateUsers(email: email)
            })
        }
    }
    
    func observeFriendsCountAndLastMessage() {
        guard let email = currentUser.email else { return }
        // Наблюдатель за добавлением/удалением друзей
        self.database.collection(Firebase.shared.userCollectionFriendsPath(email)).addSnapshotListener(includeMetadataChanges: true) { list, error in
            let doc = list?.documents
            doc?.forEach({ data in
                
            })
        }
    }
    
    func updateUsers(email: String) {
        self.database.document(Firebase.shared.userPath(email)).addSnapshotListener { data, error in
            //Получить словарь с пользователем из firebase
            Firebase.shared.getDictionaryUser(email: email) { data in
                //Сохранить или обновить его для core data
                CoreData.shared.updateUserData(data: data, completion: { user in
                    //Достать его из core data и назначить в наблюдаемое свойство
                    CoreData.shared.requestNetworkUsers { users in
                        switch users {
                        case .success(let users):
                            self.friends.accept(users.filter({$0.currentUser == false}))
                        default:
                            break
                        }
                    }
                })
            }
        }
    }
    
    
    func removeFriend(indexPath: IndexPath) {
        
        
    }
    
    func goToPrivateChat(companion: NetworkUser) {
        router?.pushToPrivateChatViewController(currentUser: currentUser, companion: companion)
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
