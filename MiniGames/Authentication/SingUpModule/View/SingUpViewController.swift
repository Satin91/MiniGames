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
    //Labels
    @IBOutlet weak var createAccountLabel: RegularLabel!
    @IBOutlet weak var googleLogInLabel: UILabel!
    //TextFields
    @IBOutlet weak var nameTextField: RegularTextField!
    @IBOutlet weak var emailTextField: RegularTextField!
    @IBOutlet weak var passwordTextField: RegularTextField!
    //View
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var lineViewRight: UIView!
    @IBOutlet weak var lineViewLeft: UIView!
    //Buttons
    @IBOutlet weak var registerButtonOutlet: FilledButton!
    @IBOutlet weak var googleButton: UIButton!
    
    
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
        setupButtons()
        setupLabels()
        setupLineViews()
    }
    
    
    //MARK: Action funcs
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, name != "",
              let email = emailTextField.text, email != "",
              let password = passwordTextField.text, password != "" else { return }
        presenter?.registerButtonPressed(name: name, email: email, password: password, avatar: avatarName)
    }
    
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        presenter?.registerWithGoogle(avatar: avatarName)
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
    
    private func setupLabels() {
        createAccountLabel.font = .MGFont(size: 28, weight: .bold)
        googleLogInLabel.textColor = .MGSubTitle
    }
    
    private func setupImageView() {
        userAvatarImageView.image = UIImage(named: avatarName)
    }
    
    private func setupButtons() {
        registerButtonOutlet.titleLabel?.font = .MGFont(size: 16, weight: .bold)
        googleButton.layer.cornerRadius = 12
        googleButton.layer.cornerCurve = .continuous
        googleButton.titleLabel?.font = .MGFont(size: 16, weight: .bold)
        googleButton.setTitleColor(.MGTitle, for: .normal)
        let googleImage = UIImageView(frame: CGRect(x: 14, y: 0, width: 50, height: 50))
        googleImage.image = UIImage(named: "googleImage")
        googleButton.addSubview(googleImage)
    }
    
    private func setupLineViews() {
        let lineHeight = CGFloat(1)
        let rightline = UIView(frame: CGRect(x: 0, y: lineViewRight.bounds.height / 2 + lineHeight, width: lineViewRight.bounds.width, height: lineHeight))
        let leftLine = UIView(frame: CGRect(x: 0, y: lineViewLeft.bounds.height / 2 + lineHeight, width: lineViewLeft.bounds.width, height: lineHeight))
        
        rightline.backgroundColor = .MGSubTitle
        leftLine.backgroundColor = .MGSubTitle
        
        lineViewRight.addSubview(rightline)
        lineViewLeft.addSubview(leftLine)
        
        lineViewRight.backgroundColor = .clear
        lineViewLeft.backgroundColor = .clear
    }
}
