//
//  PrivateChatPresenter.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol PrivateChatViewProtocol: AnyObject {
    func reloadMessages()
}

protocol PrivateChatPresenterProtocol: AnyObject {
    var address: String? { get set }
    var messages: [Message]? { get set }
    var currentUser: NetworkUserModel { get set }
    var companion: NetworkUserModel { get set }
    func sendMessage(text:String)
    init(view: PrivateChatViewProtocol, router: RouterProtocol, currentUser: NetworkUserModel, companion: NetworkUserModel)
}

class PrivateChatPresenter: PrivateChatPresenterProtocol {
    
    //MARK: Properties
    weak var view: PrivateChatViewProtocol?
    let database = Database.database().reference()
    var currentUser: NetworkUserModel
    var companion: NetworkUserModel
    var address: String?
    var messages: [Message]? = []
    
    required init(view: PrivateChatViewProtocol, router: RouterProtocol, currentUser: NetworkUserModel, companion: NetworkUserModel) {
        self.view = view
        self.currentUser = currentUser
        self.companion = companion
        observeMessages {
            self.view?.reloadMessages()
        }
    }
    
    
    //MARK: Delegate func
    func sendMessage(text: String) {
        let message = PrivateChatMessageModel(name: currentUser.name, text: text, id: currentUser.id, date: Date().getStringDate(), email: currentUser.email)
        database.child(fullAddress()).setValue(message.message)
    }
    
    //MARK: Private funcs
    private func fullAddress() -> String {
        let address = "chats/\(safeEmail(email: "\(currentUser.email)+\(companion.email)"))/messages/\(Date().getStringDate())"
        return address
    }
    
    private func observeMessages(completion: @escaping () -> Void) {
        database.child("chats/\(safeEmail(email: "\(currentUser.email)+\(companion.email)"))/messages").observe(.childAdded) { snapshot in
            guard let data = snapshot.value as? [String:String] else { return }
            let message = Message(sender: Sender(senderId: data["id"]!, displayName: data["name"]!) , messageId: data["date"]!, sentDate: Date().dateFromFirebase(stringDate: data["date"]!), kind: .text(data["text"]!))
            self.messages?.append(message)
            completion()
        }
    }
    
    private func safeEmail(email: String)-> String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}


