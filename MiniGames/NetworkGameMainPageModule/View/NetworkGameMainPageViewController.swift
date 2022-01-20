//
//  NetworkGameMainPageViewController.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit

class NetworkGameMainPageViewController: UIViewController, NetworkGameMainPageViewProtocol {
    
    // MARK: Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: RegularLabel!
    @IBOutlet weak var tableView: RegularTableView!
    
    // MARK: Properties
    var presenter: NetworkGameMainPagePresenterProtocol!
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        setupNavBar()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    //MARK: Action funcs
    @objc func rightBarButton(_ button: UIButton) {
        let searchView = UserSearchView(owner: self.view)
        searchView.show()
    }
    
    @objc func leftBarButton(_ button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Private funcs
    private func setupView() {
        view.backgroundColor = .MGBackground
    }
    
    private func setupNavBar() {
        title = "Друзья"
        self.navigationItem.setMGButtonItem(imageName: "addUser", position: .right, target: self, action: #selector(rightBarButton))
        self.navigationItem.setMGButtonItem(imageName: "back", position: .left, target: self, action: #selector(leftBarButton))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setupTableView()
        tableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil) , forCellReuseIdentifier: PlayersTableViewCell.id)
    }
    
    private func setupImageView() {
        guard let avatar = presenter.avatar else { return }
        userImage.image = UIImage(named: avatar)
        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.backgroundColor = .MGRegularImage
        userImage.clipsToBounds = true
    }
    
    private func setupLabel() {
        nameLabel.text = presenter.name
    }
    
    
    // MARK: Delegate funcs
    func addUser() {
        
    }
    
    func fillTheData() {
        setupImageView()
        setupLabel()
        tableView.reloadData()
    }
}

extension NetworkGameMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayersTableViewCell.id, for: indexPath) as! PlayersTableViewCell
        guard let friends = presenter.friends else { return cell }
        let object = friends[indexPath.row]
        cell.configureFriendsCell(player: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToPrivateChat(friendIndex: indexPath)
    }
    
}
