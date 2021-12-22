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
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
    
    func addGameToChildView(game: inout GameProtocol, presenter: GamePresenterProtocol) {
        game.gamePresenter = presenter
        guard let game = game as? UIViewController else { return }
        addChild(game)
        game.view.frame = gameView.bounds
        gameView.addSubview(game.view)
        game.didMove(toParent: self)
//        if var game2 = game as? GameProtocol {
//            game.gamePresenter = presenter
//        }
    }
    
    
    
    
    
    
    func addGameToChildView(game: GameProtocol, presenter: GamePresenterProtocol) {
        
     
       // print("Game protocol\(gameProtocol.gamePresenter = presenter)")
        //gameProtocol.gamePresenter = self.presenter
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  presenter.players?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersCell", for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    
}

extension GameViewController: UICollectionViewDelegate {
    
}



