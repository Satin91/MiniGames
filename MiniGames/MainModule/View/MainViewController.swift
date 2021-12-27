//
//  ViewController.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var helloLabel: UILabel!
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MGBackground
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playOnOneDevice(_ sender: UIButton) {
        presenter?.tappedOnButton(text: "Текст изменился :D")
    }
}


extension MainViewController: MainViewProtocol {
    func changeLabel(text: String) {
        self.helloLabel.text = text
    }
}
