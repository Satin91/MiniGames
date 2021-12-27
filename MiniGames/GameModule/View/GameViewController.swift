//
//  GameViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    // MARK: Properties
    var presenter: GamePresenterProtocol!
    var gameProtocol: GameProtocol!
    var playerResult: PlayersGameModel?
    var currentGame: GameProtocol!
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        view.backgroundColor = .MGBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.presentGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionViewLayout()
    }
}

extension GameViewController: GameViewProtocol {
    
    
    func moveCollectionView(toIndex: IndexPath) {
        self.collectionView.scrollToItem(at: toIndex, at: .centeredHorizontally, animated: true)
    }
    
    func addGameToChildView(game: GameProtocol, presenter: GamePresenterProtocol, players: [SingleUserModel]?) {
        self.currentGame = game
        currentGame.presenter = presenter
        currentGame.players = players
        guard let currentGame = game as? UIViewController else { return }
        addChild(currentGame)
        currentGame.view.frame = gameView.bounds
        gameView.addSubview(currentGame.view)
        currentGame.didMove(toParent: self)
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  presenter.players?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersCell", for: indexPath)
        guard let player = presenter.players?[indexPath.row] else { return cell }
        let image = UIImageView(image: UIImage(named: player.avatar!))
        image.frame = cell.bounds
        image.contentMode = .scaleAspectFit
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 18
        cell.backgroundView = image
        return cell
    }
    
    
}

extension GameViewController: UICollectionViewDelegate {
    
}



