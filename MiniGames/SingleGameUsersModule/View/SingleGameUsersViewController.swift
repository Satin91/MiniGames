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
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Properties
    var presenter: SingleGamePlayersPresenterProtocol!
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    // MARK: Action funcs
    @IBAction func createUser(_ sender: UIButton) {
        self.showAlert(title: "Новый участник", message: "Введите имя") { name in
            guard let name = name else { return }
            self.presenter?.saveUser(name: name)
        }
    }
    
    @IBAction func chooseAGame(_ sender: UIButton) {
        presenter.chooseAGame()
    }
    
    
    // MARK: Private funcs
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SingleGameCell")
    }
}


extension SingleGameUsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleGameCell", for: indexPath)
        let object = presenter.players?[indexPath.row]
        cell.textLabel?.text = object!.name
        return cell
    }
}

extension SingleGameUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.removeUser(indexPath: indexPath) {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension SingleGameUsersViewController: SingleGamePlayersViewProtocol {
    
    func addUser() {
        tableView.insertRows(at: [IndexPath(row: presenter.players!.count - 1, section: 0)], with: .automatic)
    }
    
    
}


