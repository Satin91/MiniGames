//
//  GameScene.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import SpriteKit

protocol TouchButton {
    func touchParentButton()
}

class GameScene: SKScene, TouchButton {
   
    
    
    var duration: TimeInterval = 0
    var gameViewController: RandomNumberViewController?
    var bottle: SKSpriteNode = SKSpriteNode()
    var rotateRec = UIRotationGestureRecognizer()
    var rotate: CGFloat = 0
    var angle: CGFloat  = 0.1
    var offset: CGFloat  = 0
    var shouldDecelerate = false
    
    override func didMove(to view: SKView) {
        self.bottle = self.childNode(withName: "bottle") as! SKSpriteNode
        bottle.size = CGSize(width: 240, height: 240)
        gameViewController?.touchButtonDelegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shouldDecelerate = true
     //   goToPoint(toAngle: 5)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shouldDecelerate = false
        bottle.speed = 1
        bottle.run(SKAction.speed(to: bottle.speed, duration: 1/30))
     //   angle -= 0.1
    }
    func runAction() {
        goToPoint(toAngle: angle)
        if bottle.speed > 0 && shouldDecelerate {
            //let newSpeed = max(bottle.speed + 0.01, 0)
            let newSpeed = bottle.speed + 0.001
            self.angle += 0.001
            bottle.run(SKAction.speed(to: newSpeed, duration: 1/30))
            print(bottle.position.y)
        }
    }
    func touchBegan() {
        goToPoint(toAngle: angle)
        bottle.speed = 1
        if bottle.speed > 0 && shouldDecelerate {
            //let newSpeed = max(bottle.speed + 0.01, 0)
            let newSpeed = bottle.speed + 0.001
            self.angle += 0.001
            bottle.run(SKAction.speed(to: newSpeed, duration: 1/30))
            print(bottle.position.y)
        }
    }
    func touchParentButton() {
       touchBegan()
        runAction()
        goToPoint(toAngle: 0.4)
    }
    
    override func update(_ currentTime: TimeInterval) {
       
    }
    
    func goToPoint(toAngle: CGFloat) {

        let action = SKAction.rotate(byAngle: toAngle, duration: 0)
        rotate += toAngle
        bottle.run(action)
    }
}

