//
//  RandomNumberViewController.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit

class RandomNumberViewController: UIViewController, GameProtocol {
    
    @IBOutlet weak var RandomNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionTapped(_ sender: UIButton) {
        
        let randomInt = Int.random(in: 0..<100)
        RandomNumberLabel.text = String(randomInt)
    }
    
}

