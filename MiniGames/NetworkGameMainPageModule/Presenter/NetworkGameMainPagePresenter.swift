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
    var searchingFriendObserver: BehaviorRelay<[[String:String]]> { get set }
    func selectedSearchTableViewRow(data: [String: String], completion: @escaping ()-> Void)
    func searchFriends(email: String)
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
    var searchingFriendObserver: BehaviorRelay<[[String : String]]>
    let realtimeDatabase = Database.database().reference()
    //MARK: Properties
    weak var view: NetworkGameMainPageViewProtocol?
    var router: RouterProtocol?
    let database = Firestore.firestore()
    //Queue
    let serialQueue = DispatchQueue(label: "serial",qos: .userInteractive ,attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)
    
    required init(view: NetworkGameMainPageViewProtocol, router: RouterProtocol, currentUser: NetworkUser) {
        self.view = view
        self.router = router
        self.currentUser = currentUser
        self.currentUserObserver = Observable.of(currentUser).asObservable()
        self.friends = BehaviorRelay(value: [NetworkUser]())
        self.searchingFriendObserver = BehaviorRelay(value: [[:]])
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
    
    func searchFriends(email: String) {
        
        serialQueue.async { [weak self] in
            self?.semaphore.wait()
            
            guard let email = email.safeEmail() else {
                self?.searchingFriendObserver.accept([[:]])
                self?.semaphore.signal()
                return }
            
            self?.database.document("users/\(email)").getDocument { [weak self] snapshot, error in
                let data = snapshot?.data() as? [String: String]
                if data == nil {
                    self?.searchingFriendObserver.accept([[:]])
                    self?.semaphore.signal()
                } else {
                    self?.searchingFriendObserver.accept([data!])
                    self?.semaphore.signal()
                }
            }
        }
    }
    
    func selectedSearchTableViewRow(data: [String: String], completion: @escaping ()-> Void) {
        let searchingEmail = data["email"]!
        
        let friend = FriendModel(chatID: "", email: searchingEmail)
        self.database.collection(Firebase.shared.userCollectionFriendsPath(currentUser.email!)).getDocuments { snap, error in
            let exist = snap?.documents.contains(where: { doc in
                doc.documentID == searchingEmail
            })
            
            if exist != nil && exist == false {
                //add friend to current youser
                self.database.collection(["users",self.currentUser.email!,"friends"].joined(separator: "/")).document(searchingEmail).setData(friend.friend)
                
                //add friend to searching user
                self.database.collection(["users",searchingEmail,"friends"].joined(separator: "/")).document(self.currentUser.email!).setData(friend.friend)
                
                self.updateUsers(email: data["email"]!)
                completion()
                //Обнулить список по завершению работы метода
                self.searchingFriendObserver.accept([[:]])
            } else {
                completion()
                //Обнулить список по завершению работы метода
                self.searchingFriendObserver.accept([[:]])
                print("есть такой друг")
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
