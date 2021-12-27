//
//  RandomNumberViewController.swift
//  MiniGames
//
//  Created by Артур on 27.12.21.
//

import UIKit

class RandomNumberViewController: UIViewController, GameProtocol {
    
    
    var gameName: String { return "Случайное число" }
    
    var presenter: GamePresenterProtocol?
    
    var players: [SingleUserModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func sendResult(result: Double, index: Int?) {
        
    }
    
}
