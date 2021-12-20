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


extension GameViewController: GameViewProtocol {
   
    func addGameToChildView(game: GameProtocol) {
        guard let game = game as? UIViewController else { return }
        addChild(game)
        game.view.frame = gameView.bounds
        gameView.addSubview(game.view)
        game.didMove(toParent: self)
    }
    
    
}
