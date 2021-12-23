//
//  GameScene.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import SpriteKit

protocol LinkedToGameVC: SKScene {
    func requestResult()
    var owner: GameProtocol? { get set }
    var players: [SingleUserModel]? { get set}
}

class GameScene: SKScene, LinkedToGameVC {
    
    
    
    var duration: TimeInterval = 0
    var bottle = SKSpriteNode()
    var rotateRec = UIRotationGestureRecognizer()
    var rotate: CGFloat = 1
    var owner: GameProtocol?
    var players: [SingleUserModel]?
    let backgroundObject = SKNode()
    var playersObjects: [SKShapeNode] = []
    var circle = SKShapeNode()
    let circleRadius: CGFloat = 300
    override func didMove(to view: SKView) {
        self.addChild(backgroundObject)
        createCircle()
        createFlippingObject()
        createPlayers()
        self.backgroundColor = .systemOrange
    }
    
    func createFlippingObject() {
        bottle = SKSpriteNode(imageNamed: "bottle")
        bottle.size = CGSize(width: 240, height: 240)
        bottle.position = CGPoint(x: 0.0, y: 0.0)
        bottle.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        backgroundObject.addChild(bottle)
        
    }
    
    
    
    func createPlayers() {
        
        let center = CGPoint(x: 0, y: 0)
        let radius: CGFloat = circleRadius
        let count = self.players!.count
        let itemSize = CGFloat(120)
        let pi = Double.pi
        var angle = CGFloat(2 * pi)
        let step = CGFloat(2 *  pi) / CGFloat(count)
        
        for _ in 0...count {

            let x = cos(angle) * radius + center.x
            let y = sin(angle) * radius + center.y
                     
            angle += step
            
            let player = SKShapeNode(rect: CGRect(x: x - (itemSize / 2), y: y - (itemSize / 2), width: itemSize, height: itemSize) , cornerRadius: 16)
            player.fillColor = .white
            
            self.playersObjects.append(player)
        }
        
        playersObjects.forEach { object in
            backgroundObject.addChild(object)
        }
    }
    
    func createCircle() {
        circle = SKShapeNode(circleOfRadius: circleRadius ) // Size of Circle
        
        circle.position = CGPoint(x: frame.midX, y: frame.midY)  //Middle of Screen
        circle.strokeColor = SKColor.gray
        circle.glowWidth = 1.0
        circle.fillColor = SKColor.systemPink
        backgroundObject.addChild(circle)
    }
    
    func requestResult() {
        responseResult()
    }
    
    
    func playerAnimate(index: Int) {
        let action = SKAction.rotate(toAngle: 5, duration: 0.5)
        self.playersObjects[index].run(action)
    }
    
    func responseResult() {
        
        let returnToZeroAction = SKAction.rotate(toAngle: 0, duration: 0.2)
        returnToZeroAction.timingMode = .easeInEaseOut
        
        let angle = CGFloat.random(in: 120..<180)
        let degree360: CGFloat = 6.28319
        let part = degree360 / CGFloat(players!.count)
        
        let flip = Int(angle / degree360)
        let totalPrats = angle / part
        let res = players!.count * flip
        let winner = (Int(totalPrats) - res)
        
        owner?.sendResult(result: Double(winner), index: nil)
        let action = SKAction.rotate(byAngle: angle, duration: 4)
        action.timingMode = .easeInEaseOut
        
        let sequence = SKAction.sequence([returnToZeroAction,action])
        bottle.run(sequence)
        playerAnimate(index: winner)
    }
    
    
    
}


