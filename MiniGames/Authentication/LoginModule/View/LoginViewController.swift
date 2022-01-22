//
//  LoginViewController.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    //MARK: Outlets
    @IBOutlet weak var loginTextField: RegularTextField!
    @IBOutlet weak var passwordTextField: RegularTextField!
    @IBOutlet weak var errorLabel: RegularLabel!
    
    
    //MARK: Properties
    var presenter: LoginPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setupView()
        setupErrorLabel()
        presenter?.statusText.bind({ [weak self] text in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.errorLabel.text = text
            }
        })
    }
    
    
    //MARK: Action funcs
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        //sender.isEnabled = false
        presenter?.enterLoginAndPass(login: login, password: password)
    }
    
    @IBAction func singUpButtonTapped(_ sender: UIButton) {
        presenter?.singUpButtonPressed()
    }
    
    //MARK: Private funcs
    private func setupErrorLabel() {
        errorLabel.text = ""
        errorLabel.textColor = .MGSaturatedImage
    }
    private func setupView() {
        view.backgroundColor = .MGBackground
    }
    deinit {
        
        print("Deinit login")
    }
}
