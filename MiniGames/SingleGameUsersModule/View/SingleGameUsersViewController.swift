//
//  SingleGameListViewController.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit
import SwiftUI

class SingleGameUsersViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: RegularTableView!
    
    
    //MARK: Properties
    var presenter: SingleGamePlayersPresenterProtocol!
    var createUserScreen: CreateSingleGameUserView?
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        setupView()
    }
    
    @objc func leftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightBarButton() {
        guard createUserScreen == nil else { return }
        self.createUserScreen = CreateSingleGameUserView(owner: self.view)
        self.createUserScreen!.show { name, avatar in
            self.presenter?.saveUser(name: name, avatar: avatar)
            
        }
        self.createUserScreen = nil
    }
    
    @IBAction func chooseAGame(_ sender: UIButton) {
        presenter.chooseAGame()
    }
    
    
    // MARK: Private funcs
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil) , forCellReuseIdentifier: PlayersTableViewCell.id)
    }
    
    private func setupNavBar() {
        self.navigationItem.setMGButtonItem(imageName: "person.fill.badge.plus", position: .right, target: self, action: #selector(rightBarButton))
        self.navigationItem.setMGButtonItem(imageName: "arrow.backward", position: .left, target: self, action: #selector(leftBarButton))
    }
    
    private func setupView() {
        self.view.backgroundColor = .MGBackground
    }
}


extension SingleGameUsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayersTableViewCell.id, for: indexPath) as! PlayersTableViewCell
        
        let object = presenter.players?[indexPath.row]
        cell.configureCell(player: object!)
        return cell
    }
}

extension SingleGameUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let object = presenter.players![indexPath.row]
        object.isParticipant.toggle()
        presenter.updateUser(index: indexPath)
        guard let cell = tableView.cellForRow(at: indexPath) as? PlayersTableViewCell else { return }
        cell.configureCell(player: object)
//        presenter.removeUser(indexPath: indexPath) {
//            //tableView.deleteRows(at: [indexPath], with: .fade)
//        }
    }
    
}

extension SingleGameUsersViewController: SingleGamePlayersViewProtocol {
    
    func addUser() {
        tableView.insertRows(at: [IndexPath(row: presenter.players!.count - 1, section: 0)], with: .automatic)
    }
    
    
}


