//
//  SingleGameListViewController.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

class SingleGameListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: SingleGameListPresenterProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SingleGameCell")
    }
    
    @IBAction func createUser(_ sender: UIButton) {
        self.showAlert(title: "Новый участник", message: "Введите имя") { name in
            guard let name = name else { return }
            self.presenter?.getUser(name: name)
        }
    }
}

extension SingleGameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleGameCell", for: indexPath)
        let object = presenter.model?[indexPath.row]
        cell.textLabel?.text = object!.name
        return cell
    }
    
    
}

extension SingleGameListViewController: UITableViewDelegate {
    
}

extension SingleGameListViewController: SingleGameListViewProtocol {
    
    func addUser() {
        tableView.insertRows(at: [IndexPath(row: presenter.model!.count - 1, section: 0)], with: .fade)
        //tableView.reloadData()
    }
    
    
}
