//
//  RandomNumberViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit
import SpriteKit
import GameplayKit
import CloudKit

class RandomNumberViewController: UIViewController, GameProtocol {
   
    
    
    // MARK: Outlets
    @IBOutlet weak var button: UIButton!
    
    // MARK: Properties
    var currentGame: SKScene?
    weak var gameViewProtocol: GameViewProtocol!
    weak var gamePresenter: GamePresenterProtocol?
    var timer: Timer?
    var speedAmmo = 20
    var touchButtonDelegate: LinkedToGameVC?
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSceneToView()
    }
    
    
    // MARK: Overriden properties
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
    func sendResult(result: Double) {
        gamePresenter?.getResult(score: result)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //     MARK: Action funcs
    @IBAction func actionTapped(_ sender: Any) {
        //        print(#function)
        //        print(currentGame == nil)
        //        currentGame?.goToPoint(toAngle: 4)
        let randomInt = Int.random(in: 0..<100)
        self.touchButtonDelegate?.touchParentButton()
        
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
                scene.gameProtocol = self
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

