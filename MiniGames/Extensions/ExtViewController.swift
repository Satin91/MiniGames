//
//  ViewController.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let action = UIAlertAction(title: "Создать", style: .default) { _ in
            completion(alert.textFields!.first?.text)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
