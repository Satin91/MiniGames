//
//  GameScene.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import SpriteKit
import SwiftUI

protocol LinkedToGameVC: SKScene {
    func requestResult()
    var owner: GameProtocol? { get set }
    var players: [SingleUserModel]? { get set}
}

class GameScene: SKScene, LinkedToGameVC {
    
    weak var owner: GameProtocol?
    
    var bottle = SKSpriteNode()
    var rotateRec = UIRotationGestureRecognizer()
    var rotate: CGFloat = 1
    var players: [SingleUserModel]?
    let backgroundObject = SKNode()
    var playersObjects: [SKShapeNode] = []
    var circle = SKShapeNode()
    let circleRadius: CGFloat = 300
    
    //Flip values
    let degree360: CGFloat = 6.28319
    lazy var part = degree360 / CGFloat(players!.count)
    lazy var stridedNubers = getNumberArray(start: degree360 * 4, stride: part)
    
    override func didMove(to view: SKView) {
        self.addChild(backgroundObject)
        createCircle()
        createFlippingObject()
        createPlayers()
        backgroundObject.scene?.backgroundColor = .clear
    }
    
    func createFlippingObject() {
        bottle = SKSpriteNode(imageNamed: "bottle")
        bottle.size = CGSize(width: 240, height: 240)
        bottle.position = CGPoint(x: 0.0, y: 0.0)
        //  bottle.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        backgroundObject.addChild(bottle)
        
    }
    
    
    func createPlayers() {
        let radius: CGFloat = circleRadius
        let count = self.players!.count
        let itemSize = CGFloat(120)
        let pi = Double.pi
        var angle = CGFloat(2 * pi)
        let step = (CGFloat(2 *  pi) / CGFloat(count))
        for i in 0..<count {
            
            let y = cos(angle + (step / 2)) * radius
            let x = sin(angle + (step / 2)) * radius
            let rect = CGRect(x: x - (itemSize / 2) , y: y - (itemSize / 2), width: itemSize, height: itemSize)
            
            
            
            self.createUser(rect: rect, imageName: (self.players![i].avatar)!)
            angle += step
        }
    }
    
    func createUser(rect: CGRect, imageName: String) {
        let player = SKShapeNode(rect: CGRect(x: rect.origin.x , y: rect.origin.y, width: rect.width, height: rect.height) , cornerRadius: 16)
        let node = SKShapeNode(rect: player.frame, cornerRadius: 18)
        node.fillColor = .white
        node.fillTexture = SKTexture(imageNamed: imageName)
        player.fillColor = .white
        player.addChild(node)
        self.playersObjects.append(player)
        backgroundObject.addChild(player)
    }
    
    func createCircle() {
        circle = SKShapeNode(circleOfRadius: circleRadius ) // Size of Circle
        circle.position = CGPoint(x: frame.midX, y: frame.midY)  //Middle of Screen
        //circle.strokeColor = SKColor.gray
        //circle.glowWidth = 1.0
        // circle.fillColor = SKColor.systemPink
        // backgroundObject.addChild(circle)
    }
    
    func requestResult() {
        responseResult()
    }
    
    
    func playerAnimate(index: Int) {
        let action = SKAction.rotate(toAngle: 5, duration: 0.5)
        self.playersObjects[index].run(action)
    }
    
    
    func getNumberArray(start: CGFloat, stride: CGFloat) -> [CGFloat] {
        
        var array: [CGFloat] = []
        var sum: CGFloat = start
        let end = players!.count * 12
        for _ in 0...end {
            array.append(sum)
            sum += stride
        }
        return array
    }
    
    func setupValues() {
        
    }
    func responseResult() {
        
        let duration: TimeInterval = 3
        
        let randomNumber = Int.random(in: 0..<stridedNubers.count)
        
        let angle = CGFloat(stridedNubers[randomNumber] - part / 2)
        let flip = Int(angle / degree360)
        let totalPrats = angle / part
        let res = players!.count * flip
        let winner = (Int(totalPrats) - res )
        
        
        let action = SKAction.rotate(byAngle: angle, duration: duration)
        action.timingMode = .easeInEaseOut
        bottle.run(action)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 1) { [weak self] in
            self?.zeroAngle()
            self?.owner?.sendResult(result: Double(winner), index: nil)
        }
    }
    
    func zeroAngle() {
        let returnToZeroAction = SKAction.rotate(toAngle: 0, duration: 0.5, shortestUnitArc: true)
        returnToZeroAction.timingMode = .easeInEaseOut
        self.bottle.run(returnToZeroAction)
    }
}


