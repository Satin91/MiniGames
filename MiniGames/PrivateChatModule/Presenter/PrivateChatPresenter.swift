//
//  PrivateChatPresenter.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

protocol PrivateChatViewProtocol: AnyObject {
    
}

protocol PrivateChatPresenterProtocol: AnyObject {
    var address: String? { get set }
    var messages: Dynamic<[Message]>  { get set }
    var currentUser: NetworkUser { get set }
    var companion: NetworkUser { get set }
    func sendMessage(text:String)
    init(view: PrivateChatViewProtocol, router: RouterProtocol, currentUser: NetworkUser, companion: NetworkUser)
}

class PrivateChatPresenter: PrivateChatPresenterProtocol {
    
    
    
    //MARK: Properties
    weak var view: PrivateChatViewProtocol?
    let database = Database.database().reference()
    var currentUser: NetworkUser
    var companion: NetworkUser
    var address: String?
    var messages: Dynamic<[Message]> = Dynamic([Message]())
    
    required init(view: PrivateChatViewProtocol, router: RouterProtocol, currentUser: NetworkUser, companion: NetworkUser) {
        self.view = view
        self.currentUser = currentUser
        self.companion = companion
        observeMessages()
    }
    
    let firestore = Firestore.firestore()
    //MARK: Delegate func
    func sendMessage(text: String) {
        let message = PrivateChatMessageModel(name: currentUser.name!, text: text, id: currentUser.id!, date: Date().getStringDate(), email: currentUser.email!)
        
        self.database.child("chats/\(self.companion.chatID!)/messages/\(Date().getStringDate())").setValue(message.message)
    }
    
    //MARK: Private funcs
    private func observeMessages() {
        
        self.database.child("chats/\(self.companion.chatID!)/messages").observe(.childAdded) { [weak self] snapshot in
            guard let data = snapshot.value as? [String:String] else { return }
            let message = Message(sender: Sender(senderId: data["id"]!, displayName: data["name"]!) , messageId: data["date"]!, sentDate: Date().dateFromFirebase(stringDate: data["date"]!), kind: .text(data["text"]!))
            self?.messages.value.append(message)
        }
    }
}


