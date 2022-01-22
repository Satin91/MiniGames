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
        createBindings()
        
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    //MARK: Action funcs
    @objc func rightBarButton(_ button: UIButton) {
        let searchView = UserSearchView(owner: self.view)
        searchView.show()
    }
    
    @objc func leftBarButton(_ button: UIButton) {
        presenter.backToMainViewController()
    }
    
    //MARK: Action funcs
    @IBAction func showContextMenuButtonTapped(_ sender: UIButton) {
        self.showContextMenu(holderView: userImage, data: presenter.contextData) { [weak self] index in
            self?.presenter.didTappedContextCell(index: index)
        }
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
        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.backgroundColor = .MGRegularImage
        userImage.clipsToBounds = true
    }
    
    func createBindings() {
        presenter.currentUser.bind({ [weak self] user in
            self?.nameLabel.text = user.name
            self?.userImage.image = UIImage(named: user.avatar!)
            
        })
        presenter.friends.bind { [weak self] users in
            self?.tableView.reloadData()
        }
        
        self.presenter.getUsersFromCoreData()
    }
    
 
    // MARK: Delegate funcs
    deinit {
        print("Deinit Network game")
    }
}

extension NetworkGameMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayersTableViewCell.id, for: indexPath) as! PlayersTableViewCell
        let friends = presenter.friends.value
        let object = friends[indexPath.row]
        cell.configureFriendsCell(player: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToPrivateChat(friendIndex: indexPath)
    }
    
}
