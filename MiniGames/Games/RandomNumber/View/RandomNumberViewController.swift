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
    
    // MARK: Outlets
    @IBOutlet weak var button: UIButton!
    
    // MARK: Properties
    var currentGame: SKScene?
    weak var gameViewProtocol: GameViewProtocol!
    weak var gamePresenter: GamePresenterProtocol?
    var timer: Timer?
    var speedAmmo = 20
    var touchButtonDelegate: TouchButton?
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(buttonDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonUp), for: [.touchUpInside, .touchUpOutside])
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func buttonDown(_ sender: UIButton) {
        singleFire()
        touchButtonDelegate?.touchParentButton()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(rapidFire), userInfo: nil, repeats: true)
    }
    
    @objc func buttonUp(_ sender: UIButton) {
        timer?.invalidate()
    }
    
    func singleFire() {
    }
    
    @objc func rapidFire() {
        if speedAmmo > 0 {
            speedAmmo -= 1
            print("bang!")
        } else {
            print("out of speed ammo, dude!")
            timer?.invalidate()
        }
    }
    
    // MARK: Action funcs
    //    @IBAction func actionTapped(_ sender: Any) {
    ////        print(#function)
    ////        print(currentGame == nil)
    ////        currentGame?.goToPoint(toAngle: 4)
    //        let randomInt = Int.random(in: 0..<100)
    //        gamePresenter?.getResult(score: Double(randomInt))
    //    }
    
    
    // MARK: Private funcs
    func addSceneToView() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                currentGame = scene
                
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

