//
//  ViewController.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    
    
    //MARK: Properties
    var presenter: MainPresenterProtocol?
    
    
    //MARK: Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHeaderLabel()
      //  try! FirebaseAuth.Auth.auth().signOut()
    }
    
    
    //MARK: Action funcs
    @IBAction func playOnOneDevice(_ sender: UIButton) {
        presenter?.tappedOnSingleGameButton(text: "Текст изменился :D")
    }
    
    @IBAction func networkPlay(_ sender: UIButton) {
        presenter?.tappedOnNetworkGame()
    }
    
    
    //MARK: Private funcs
    private func setupView() {
        view.backgroundColor = .MGBackground
    }
    
    private func setupHeaderLabel() {
        headerLabel.text = "Mini games"
        headerLabel.textColor = .MGTitle
        headerLabel.font = .MGKlasikFont(size: 46)
    }
}


extension MainViewController: MainViewProtocol {
    func changeLabel(text: String) {
        self.helloLabel.text = text
    }
}
