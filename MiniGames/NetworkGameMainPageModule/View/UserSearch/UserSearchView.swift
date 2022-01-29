//
//  UserSearchView.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import Lottie
import RxSwift
import RxCocoa

class UserSearchView: UIView, GestureBackgroundDidTapped {
    
    //MARK: Properties
    private var searchTextField = RegularTextField(type: .filled, placeholder: "Введите email", image: nil)
    var searchObserver = PublishSubject<String>()
    var tableView = RegularTableView(frame: .zero, style: .insetGrouped)
    private var owner: UIView!
    private var gestureGrayBackground: GestureBackground!
    private let database = Firestore.firestore()
    private let label = RegularLabel(size: 16, weight: .regular)
    private var lottieView = AnimationView()
    private var closeButton = CircleButton(side: 30, type: .close)
    private let disposeBag = DisposeBag()
    
    //MARK: Overriden funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(owner: UIView) {
        self.init()
        self.owner = owner
        setupView()
        setupLottieView()
        setupTextField()
        setupTableView()
        setupLabel()
        setupCloseButton()
        setupConstraints()
        addGestureBackground()
        animateLottieView()
        observeTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    //MARK: Action funcs
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.close()
    }
    
    
    //MARK: Public funcs
    public func show() {
        self.gestureGrayBackground.standartShow(onView: owner)
        self.showFromRightSide(onView: owner)
    }
    
    public func close() {
        self.closeAnimation()
        self.gestureGrayBackground.closeAnimation()
    }
    
    //MARK: Private funcs
    private func setupView() {
        frame = CGRect(x: 0, y: 0, width: owner.bounds.width - Insets.horizontalIndent * 2, height: owner.bounds.height * 0.6)
        backgroundColor = .white
        layer.cornerRadius = Insets.standartCornerRadius
        layer.cornerCurve = .continuous
        clipsToBounds = true
        self.accessibilityIdentifier = "userSearch"
    }
    
    private func observeTextField() {
            self.searchTextField.rx.text.map{ $0 ?? ""}.bind(to: self.searchObserver).disposed(by: self.disposeBag)
    }
    
    private func setupLottieView() {
        self.addSubview(lottieView)
    }
    
    private func animateLottieView() {
        lottieView.animation = Animation.named("searchLottieGray")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    private func addGestureBackground() {
        gestureGrayBackground = GestureBackground(frame: owner.bounds)
        gestureGrayBackground.delegate = self
    }
    
    private func setupTextField() {
        addSubview(searchTextField)
    }
    
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil) , forCellReuseIdentifier: PlayersTableViewCell.id)
    }
    
    private func setupLabel() {
        addSubview(label)
        label.text = "Найти друга"
        label.textAlignment = .center
        label.font = .MGFont(size: 24, weight: .medium)
    }
    
    private func setupCloseButton() {
        self.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints       = false
        label.translatesAutoresizingMaskIntoConstraints           = false
        lottieView.translatesAutoresizingMaskIntoConstraints      = false
        closeButton.translatesAutoresizingMaskIntoConstraints     = false
        
        NSLayoutConstraint.activate([
            //CloseButton
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Insets.textIndent),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Insets.textIndent),
            //lottie view
            lottieView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            lottieView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            lottieView.topAnchor.constraint(equalTo: self.topAnchor, constant: Insets.textIndent),
            lottieView.heightAnchor.constraint(equalToConstant: self.bounds.height / 2),
            // label
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            label.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: Insets.textIndent),
            // TextField
            searchTextField.heightAnchor.constraint(equalToConstant: 60),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            searchTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Insets.textIndent),
            // TableView
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: Insets.textIndent)
        ])
    }
    
    
    //MARK: Delegate funcs
    func didTapGestureBackground() {
        self.close()
    }
}
