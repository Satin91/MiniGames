//
//  SingUpViewController.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit


class SingUpViewController: UIViewController, SingUpViewProtocol {
    
    //MARK: Outlets
    @IBOutlet weak var createAccountLabel: RegularLabel!
    @IBOutlet weak var nameTextField: RegularTextField!
    @IBOutlet weak var emailTextField: RegularTextField!
    @IBOutlet weak var passwordTextField: RegularTextField!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    
    //MARK: Properties
    var presenter: SingUpPresenter?
    var avatarName: String = "user1" {
        willSet {
            self.userAvatarImageView.image = UIImage(named: newValue)
        }
    }
    
    
    //MARK: Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        setupLabel()
    }
    
    //MARK: Action funcs
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, name != "",
              let email = emailTextField.text, email != "",
              let password = passwordTextField.text, password != "" else { return }
        presenter?.registerButtonPressed(name: name, email: email, password: password, avatar: avatarName)
    }
    
    @IBAction func selectAvatarButtonTapped(_ sender: UIButton) {
        let view = SelectAvatarView(owner: self.view)
        view.show { avatar in
            self.avatarName = avatar
        }
    }
    
    //MARK: Private funcs
    private func setupView() {
        view.backgroundColor = .MGBackground
    }
    
    func setupLabel() {
        createAccountLabel.font = .MGFont(size: 28, weight: .bold)
    }
    
    private func setupImageView() {
        userAvatarImageView.image = UIImage(named: avatarName)
    }
}
