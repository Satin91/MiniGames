//
//  RandomNumberViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit
import SpriteKit
import GameplayKit

class RandomNumberViewController: UIViewController, GameProtocol {
    
    @IBOutlet weak var RandomNumberLabel: UILabel!
    var currentGame: GameScene?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                currentGame = scene as? GameScene
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
       
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    @IBAction func actionTapped(_ sender: Any) {
        print(#function)
        print(currentGame == nil)
        currentGame?.goToPoint(toAngle: 4)
//        let randomInt = Int.random(in: 0..<100)
//        RandomNumberLabel.text = String(randomInt)
    }
    
}

