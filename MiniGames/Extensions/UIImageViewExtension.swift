//
//  UIImageViewExtension.swift
//  MiniGames
//
//  Created by Артур on 26.12.21.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let temp = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = temp
        self.tintColor = color
    }
}
