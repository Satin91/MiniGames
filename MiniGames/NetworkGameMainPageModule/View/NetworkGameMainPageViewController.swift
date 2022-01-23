//
//  NetworkGameMainPageViewController.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NetworkGameMainPageViewController: UIViewController, NetworkGameMainPageViewProtocol {
    
    // MARK: Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: RegularLabel!
    @IBOutlet weak var tableView: NetworkUsersTableView!
    
    // MARK: Properties
    var presenter: NetworkGameMainPagePresenterProtocol!
    let dispiseBag = DisposeBag()
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        setupNavBar()
        setupTableView()
        observeValues()
   
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
        tableView.data = presenter.friends.value
        tableView.delegate = self
        tableView.reloadData()
    }
    
    private func setupImageView() {
        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.backgroundColor = .MGRegularImage
        userImage.clipsToBounds = true
    }

    private func observeValues() {
        presenter.currentUserObserver.bind { [weak self] user in
            self?.nameLabel.text = user.name
            self?.userImage.image = UIImage(named: user.avatar!)
            //self?.tableView.data = users
            self?.tableView.reloadData()
        }.dispose()
        
        presenter.friends.asObservable().subscribe { friends in
            switch friends {
            case .next(let friends):
                print("FRIENDS IS LOAD \(friends)")
            default:
                break
            }
        }.dispose()
        
        presenter.friends.asObservable().subscribe(onNext: { [weak self] friends in
            self?.tableView.data = friends
            self?.tableView.reloadData()
        }).disposed(by: dispiseBag)

    }
    
    // MARK: Delegate funcs
    deinit {
        print("Deinit Network game")
    }
}

extension NetworkGameMainPageViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // presenter.removeFriend(indexPath: indexPath)
        presenter.goToPrivateChat(friendIndex: indexPath)
    }
    
}
