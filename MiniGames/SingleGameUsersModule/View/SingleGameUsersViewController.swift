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
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.dropDelegate = self
        tableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil) , forCellReuseIdentifier: PlayersTableViewCell.id)
    }
    
    private func setupNavBar() {
        title = "Игроки"
        self.navigationItem.setMGButtonItem(imageName: "addUser", position: .right, target: self, action: #selector(rightBarButton))
        self.navigationItem.setMGButtonItem(imageName: "back", position: .left, target: self, action: #selector(leftBarButton))
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
        let player = presenter.players![indexPath.row]
        cell.configureCell(player: player)
        return cell
    }
}

extension SingleGameUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = presenter.players![indexPath.row]
        player.isParticipant.toggle()
        presenter.updateUser(index: indexPath)
        guard let cell = tableView.cellForRow(at: indexPath) as? PlayersTableViewCell else { return }
        cell.configureCell(player: player)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            self.presenter.removeUser(indexPath: indexPath) {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        })
        deleteAction.image = UIImage(systemName: "trash" )
        deleteAction.backgroundColor = .MGSaturatedImage
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension SingleGameUsersViewController: SingleGamePlayersViewProtocol {
    
    func addUser() {
        tableView.insertRows(at: [IndexPath(row: presenter.players!.count - 1, section: 0)], with: .automatic)
    }
    
    
}


//MARK: - DRAG & DROP DELEGATE

extension SingleGameUsersViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let mover = presenter.players!.remove(at: sourceIndexPath.row)
        presenter.players!.insert(mover, at: destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = presenter.players![indexPath.row]
        
        return [dragItem]
    }
}

extension SingleGameUsersViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        if session.localDragSession != nil {
            
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}
