//
//  PrivateChatViewController.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Lottie


struct Sender: SenderType {
    var senderId: String
    var displayName: String
    
}

struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    
}

class PrivateChatViewController: MessagesViewController, PrivateChatViewProtocol {
    
    //MARK: Properties
    var presenter: PrivateChatPresenterProtocol!
    var lottieView = AnimationView()
    let chatBackground = UIImageView(image: UIImage(named: "chatBackground"))
    
    //MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMessageCollectionView()
        configureInputBar()
        setupChatBackground()
        setupNavBar()
        setupLottieView()
        animateLottieView()
    }
    
    
    //MARK: Private funcs
    func setupView() {
        view.backgroundColor = .MGBackground
    }
    
    private func setupMessageCollectionView() {
        messagesCollectionView.backgroundColor = .clear
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }

    private func setupChatBackground() {
        
        chatBackground.frame = view.bounds
        chatBackground.alpha = 0.8
        chatBackground.isHidden = true
        view.insertSubview(chatBackground, belowSubview: messagesCollectionView)
    }
    
    private func setupLottieView() {
        lottieView.frame = view.bounds
        lottieView.backgroundColor = .clear
        self.view.addSubview(lottieView)
    }
    
    private func animateLottieView() {
        lottieView.animation = Animation.named("lf30_editor_vxqlcgjk")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    private func setupNavBar() {
        self.navigationItem.setMGButtonItem(imageName: "back", position: .left, target: self, action: #selector(leftBarButton))
    }
    
    @objc private func leftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureInputBar() {
        messageInputBar.isTranslucent = false
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .MGFilledButton
        messageInputBar.backgroundColor = .MGFilledButton
        messageInputBar.inputTextView.placeholderTextColor = .MGSubTitle
        messageInputBar.inputTextView.textColor = .MGTitle
        messageInputBar.inputTextView.font = .MGFont(size: 16, weight: .regular)
        
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 30)
        messageInputBar.inputTextView.backgroundColor = .white
        messageInputBar.inputTextView.layer.cornerRadius = 8
        messageInputBar.inputTextView.layer.cornerCurve = .continuous
        messageInputBar.sendButton.image = UIImage(systemName: "paperplane.fill")
        messageInputBar.sendButton.tintColor = .MGTitle
        messageInputBar.sendButton.setTitle("", for: .normal)
    }
    
    
    //MARK: Delegate funcs
    func reloadMessages() {
        messagesCollectionView.reloadData()
        lottieView.isHidden = true
        chatBackground.isHidden = false
        
    }
    
}

