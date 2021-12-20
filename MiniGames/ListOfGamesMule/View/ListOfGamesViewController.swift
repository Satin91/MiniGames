//
//  GamesViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit

class ListOfGamesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Properties
    var presenter: ListOfGamesPresenterProtocol?
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    // MARK: Private funcs
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GamesCell")
    }
}
extension ListOfGamesViewController: ListOfGamesViewProtocol {
    
}

extension ListOfGamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath)
        cell.textLabel?.text = "Game \(indexPath.row)"
        return cell
    }
    
}

extension ListOfGamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectGame(indexPath: indexPath)
    }
}
