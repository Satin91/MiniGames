//
//  RegularTextField.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import Foundation
import UIKit


class RegularTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    convenience init(placeholder: String) {
        self.init()
        setupTextField()
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.MGSubTitle])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupTextField() {
        self.backgroundColor = .white
        self.borderStyle = .none
        self.textColor = .MGTitle
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 8
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
}
