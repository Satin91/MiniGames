//
//  NetworkUsersTableView.swift
//  MiniGames
//
//  Created by Артур on 23.01.22.
//

import Foundation
import UIKit
import FirebaseDatabase

class NetworkUsersTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
        registerCell()
    }
    
    var data = [NetworkUser]()
    private let database = Database.database().reference()
    
    convenience init(data: [NetworkUser]) {
        self.init()
        self.data = data
        setupTableView()
        registerCell()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
        registerCell()
    }
    
    //MARK: Private funcs
    private func configureCell(indexPath: IndexPath) -> NetworkUsersTableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: NetworkUsersTableViewCell.id, for: indexPath) as! NetworkUsersTableViewCell
        let data = self.data[indexPath.row]
        cell.userAvatarImage.image = UIImage(named: data.avatar!)
        cell.userNameLabel.text = data.name
        
        self.getLastMessage(user: data) { text in
            cell.lastMessageLabel.text = text
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func getLastMessage(user: NetworkUser, completion: @escaping(String) -> Void){
        var message: String? = ""
        let path = "chats/\(user.chatID!)/messages"
        self.database.child(path).observe(.childAdded) { data in
            guard let data = data.value as? [String: String] else { return }
            message = data["text"]!
            completion(message ?? "Last message")
        }
    }
    
    private func setupTableView() {
        self.separatorStyle = .none
        self.backgroundColor = .clear
        self.rowHeight = Insets.networkUsersTableViewRowHeight
        self.dataSource = self
    }
    
    private func registerCell() {
        self.register(UINib(nibName: NetworkUsersTableViewCell.id, bundle: nil) , forCellReuseIdentifier: NetworkUsersTableViewCell.id)
    }
}

extension NetworkUsersTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(indexPath: indexPath)
    }
    
    
    
}
