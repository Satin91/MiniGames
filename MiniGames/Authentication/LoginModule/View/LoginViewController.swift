//
//  LoginViewController.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    //MARK: Properties
    @IBOutlet weak var loginTextField: RegularTextField!
    
    @IBOutlet weak var passwordTextField: RegularTextField!
    
    var presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK: Action funcs
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text, login != "",
              let password = passwordTextField.text, password != "" else { return }
        presenter?.enterLoginAndPass(login: login, password: password)
    }
    
    @IBAction func singUpButtonTapped(_ sender: UIButton) {
        presenter?.singUpButtonPressed()
    }
    
    //MARK: Private funcs
    private func setupView() {
        view.backgroundColor = .MGBackground
    }
}
