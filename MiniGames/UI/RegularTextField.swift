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
        
    }
    
    
    enum TextFieldType {
        case regular
        case filled
    }
    
    convenience init(type: TextFieldType,placeholder: String) {
        self.init()
        commonSetup()
        switch type {
        case .regular:
            setupRegularTextField()
        case .filled:
            setupFilledTextField()
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.MGSubTitle, NSAttributedString.Key.font: UIFont.MGFont(size: 18, weight: .regular) ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonSetup() {
        self.borderStyle = .none
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 12
    }
    
    func setupFilledTextField() {
        self.backgroundColor = .MGBackground
        textColor = .MGFilledButton
        font = .MGFont(size: 18, weight: .medium)
    }
    
    func setupRegularTextField() {
        self.backgroundColor = .white
        textColor = .MGTitle
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
   
}
