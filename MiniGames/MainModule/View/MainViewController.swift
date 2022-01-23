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
    @IBOutlet weak var singleGameButtonImage: UIImageView!
    @IBOutlet weak var networkGameButtonImage: UIImageView!
    
    @IBOutlet weak var singleGameButtonHeaderLabel: UILabel!
    @IBOutlet weak var networkButtonHeaderLabel: UILabel!
    
    @IBOutlet weak var singleGameButtonDescriptionLabel: UILabel!
    @IBOutlet weak var networkGameButtonDescriptionLabel: UILabel!
    
   
    
    
    //MARK: Properties
    var presenter: MainPresenterProtocol?
    
    //MARK: Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLabels()
        setupButtonImages()
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

    private func setupLabels() {
        headerLabel.text = "Mini games"
        headerLabel.textColor = .MGTitle
        headerLabel.font = .MGKlasikFont(size: 46)
        
        networkButtonHeaderLabel.textColor = .MGTitle
        singleGameButtonHeaderLabel.textColor = .MGTitle
        
        networkGameButtonDescriptionLabel.textColor = .MGSubTitle
        singleGameButtonDescriptionLabel.textColor = .MGSubTitle
    }
    private func setupButtonImages() {
        singleGameButtonImage.image = UIImage(named: "offlineGame")
        networkGameButtonImage.image = UIImage(named: "onlineGame")
        
        singleGameButtonImage.layer.cornerRadius = singleGameButtonImage.bounds.height / 2
        networkGameButtonImage.layer.cornerRadius = singleGameButtonImage.bounds.height / 2
        singleGameButtonImage.backgroundColor = .MGBackground
        networkGameButtonImage.backgroundColor = .MGBackground
        
    }
}


extension MainViewController: MainViewProtocol {
    func changeLabel(text: String) {
        self.helloLabel.text = text
    }
}
