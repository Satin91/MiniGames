//
//  MessageKitDelegates.swift
//  MiniGames
//
//  Created by Артур on 20.01.22.
//

import UIKit
import MessageKit
import InputBarAccessoryView

extension PrivateChatViewController: MessagesDataSource,MessagesDisplayDelegate,MessagesLayoutDelegate {
    
    
    func currentSender() -> SenderType {
        let currentUser = presenter!.currentUser
        return Sender(senderId: currentUser.id, displayName: currentUser.name)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubble
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = presenter.messages![indexPath.section].sender.senderId == presenter.currentUser.id ? presenter.currentUser.avatar : presenter.companion.avatar
        avatarView.image = UIImage(named: avatar)
        avatarView.backgroundColor = .MGRegularImage
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return presenter!.messages![indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        guard let messages = presenter?.messages else { return 0}
        return messages.count
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .MGFilledButton
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .MGTitle : .MGTitle
    }
}
extension PrivateChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        resignFirstResponder()
        presenter?.sendMessage(text: text)
    }
    
}
