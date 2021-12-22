//
//  GameScene.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import SpriteKit

protocol LinkedToGameVC: SKScene {
    func touchParentButton()
    var gameProtocol: GameProtocol? { get set }
}

class GameScene: SKScene, LinkedToGameVC {
    
    
    var duration: TimeInterval = 0
    var bottle: SKSpriteNode = SKSpriteNode()
    var rotateRec = UIRotationGestureRecognizer()
    var rotate: CGFloat = 1
    var gameProtocol: GameProtocol?
    
    override func didMove(to view: SKView) {
        self.bottle = self.childNode(withName: "bottle") as! SKSpriteNode
        bottle.size = CGSize(width: 240, height: 240)
    }
    
    
    func touchParentButton() {
        goToPoint()
    }
    
    
    func goToPoint() {
        bottle.run(SKAction.rotate(toAngle: 0, duration: 0))
        let angle = CGFloat.random(in: 120..<180)
        var intArray = [0,1,2,3,4,5]
        let degree360: CGFloat = 6.28319
        var part = degree360 / CGFloat(intArray.count)
       
        var flip = Int(angle / degree360)
        var totalPrats = angle / part
        var res = intArray.count * flip
        
        let winner = (Int(totalPrats) - res)
        //let result2 = Int(result) + 1
        print(winner)
        gameProtocol?.sendResult(result: Double(winner) )
        let action = SKAction.rotate(byAngle: angle, duration: 4)
        action.timingMode = .easeInEaseOut
        bottle.run(action)
    }
    

    
}


