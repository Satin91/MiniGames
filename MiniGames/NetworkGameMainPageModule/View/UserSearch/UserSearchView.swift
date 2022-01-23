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

class UserSearchView: UIView {

    
    //MARK: Properties
    private var searchTextField = RegularTextField(type: .regular, placeholder: "Введите email", image: nil)
    private var tableView = RegularTableView(frame: .zero, style: .insetGrouped)
    private var owner: UIView!
    private let database = Firestore.firestore()
    private let currentUser = FirebaseAuth.Auth.auth().currentUser
    private let label = RegularLabel(size: 16, weight: .regular)
    
    private var searchingUser: NetworkUser? {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: Overriden funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(owner: UIView) {
        self.init()
        self.owner = owner
        setupView()
        setupTextField()
        setupTableView()
        setupLabel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    //MARK: Action funcs
   @objc private func textFieldDidChange(_ textField: UITextField) {
       guard let text = textField.text, text != "" else { return }
       searchByEmail(email: text.lowercased())
    }
    
    func searchByEmail(email: String) {
        Firebase.shared.getUser(email: email) { user in
            self.searchingUser = user
        }
    }
    
    //MARK: Public funcs
    public func show() {
        self.showFromRightSide(onView: owner)
    }
   
    
    //MARK: Private funcs
    private func setupView() {
        frame = CGRect(x: 0, y: 0, width: owner.bounds.width - Insets.horizontalIndent * 2, height: owner.bounds.height * 0.3)
        backgroundColor = .MGFilledButton
        layer.cornerRadius = Insets.standartCornerRadius
        layer.cornerCurve = .continuous
        clipsToBounds = true
        self.accessibilityIdentifier = "userSearch"
    }
    
    private func setupTextField() {
        addSubview(searchTextField)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil) , forCellReuseIdentifier: PlayersTableViewCell.id)
    }
    
    private func setupLabel() {
        addSubview(label)
        label.text = "Найти друга"
    }
    
    private func setupConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // label
            //label.heightAnchor.constraint(equalToConstant: 80),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: Insets.textIndent),
            // TextField
            searchTextField.heightAnchor.constraint(equalToConstant: 60),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            searchTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Insets.textIndent),
            // TableView
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 18),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: Insets.textIndent)
        ])
    }
}


extension UserSearchView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingUser == nil ? 0 : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayersTableViewCell.id, for: indexPath) as! PlayersTableViewCell
        if self.searchingUser != nil {
            cell.playerImage.image = UIImage(named: searchingUser!.avatar!)
            cell.playerNameLabel.text = searchingUser!.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let friend = FriendModel(lastMessage: "", chatID: "")
        friend.checkFriendExistance(searchEmail: searchingUser!.email!)
        self.closeAnimation()
    }
}
