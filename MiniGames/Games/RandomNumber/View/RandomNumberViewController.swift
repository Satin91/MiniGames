//
//  RandomNumberViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit
import SpriteKit


class RandomNumberViewController: UIViewController, GameProtocol {
    
    // MARK: Outlets
    @IBOutlet weak var button: UIButton!
    
    // MARK: Properties
    weak var gameViewProtocol: GameViewProtocol!
    weak var presenter: GamePresenterProtocol?
    weak var touchButtonDelegate: LinkedToGameVC?
    var players: [SingleUserModel]?
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSceneToView()
    }
    
    
    //     MARK: Action funcs
    @IBAction func actionTapped(_ sender: Any) {
        self.touchButtonDelegate?.requestResult()
    }

    
    // MARK: Private funcs
    func addSceneToView() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? LinkedToGameVC {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                self.touchButtonDelegate = scene
                scene.owner = self
                scene.players = players
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func sendResult(result: Double, index: Int?) {
        presenter?.getResult(score: result, index: index)
    }
    deinit {
        print("Deinit")
    }
}

