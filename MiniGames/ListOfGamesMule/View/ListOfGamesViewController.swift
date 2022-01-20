//
//  GamesViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit

class ListOfGamesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: RegularTableView!
    
    
    // MARK: Properties
    var presenter: ListOfGamesPresenterProtocol?
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    
    // MARK: Private funcs
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GamesCell")
        tableView.backgroundColor = .MGBackground
    }
    
    private func setupView() {
        
    }
}
extension ListOfGamesViewController: ListOfGamesViewProtocol {
    
}

extension ListOfGamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.games?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath)
        let game = presenter!.games![indexPath.row]
        cell.textLabel?.text = game.gameName
        return cell
    }
    
}

extension ListOfGamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectGame(indexPath: indexPath)
    }
}
