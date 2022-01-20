//
//  RegularTextField.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import Foundation
import UIKit

@IBDesignable
class RegularTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @objc enum TextFieldType: Int {
        case regular
        case filled
    }
    
    @IBInspectable var textFieldType: CGFloat = 0{
        willSet {
            switch newValue {
            case 0:
                setupFilledTextField()
            case 1:
                setupRegularTextField()
            default:
                break
            }
        }
    }
    
    @IBInspectable var withImage: String? {
        willSet {
            setLeftViewImage(name: newValue!)
        }
    }
    
    @IBInspectable var MGPlaceholder: String = "" {
        willSet {
            self.attributedPlaceholder = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.MGSubTitle, NSAttributedString.Key.font: UIFont.MGFont(size: 16, weight: .regular) ])
        }
    }
    
    //MARK: Overriden funcs
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset: CGFloat = withImage == nil ? 15 : 15 + 48
        let rect = CGRect(x: inset, y: 0, width: self.bounds.width - inset, height: bounds.height)
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let inset: CGFloat = withImage == nil ? 15 : 15 + 48
        let rect = CGRect(x: inset, y: 0, width: self.bounds.width - inset, height: bounds.height)
        return rect
    }
    
    convenience init(type: TextFieldType,placeholder: String, image: String?) {
        self.init()
        commonSetup()
        switch type {
        case .regular:
            setupRegularTextField()
        case .filled:
            setupFilledTextField()
        }
        self.withImage = image
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.MGSubTitle, NSAttributedString.Key.font: UIFont.MGFont(size: 16, weight: .regular) ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    
    //MARK: Private funcs
    private func commonSetup() {
        self.borderStyle = .none
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 12
    }
    
    private func setupFilledTextField() {
        self.backgroundColor = .MGBackground
        textColor = .MGFilledButton
        font = .MGFont(size: 16, weight: .medium)
    }
    
    private func setupRegularTextField() {
        self.backgroundColor = .white
        textColor = .MGFilledButton
        font = .MGFont(size: 16, weight: .medium)
    }
    
    public func setLeftViewImage(name: String) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 26))
        
        
        self.leftViewMode = .always
        let imageView = UIImageView()
        imageView.frame = leftView.bounds
        imageView.frame.origin.x += 8
        imageView.image = UIImage(systemName: name)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .MGSubTitle
        leftView.addSubview(imageView)
        self.leftView = leftView
        let lineView = UIView(frame: CGRect(x: leftView.bounds.width + 13, y: 0, width: 1, height: self.bounds.height) )
        lineView.backgroundColor = .MGBackground
        self.addSubview(lineView)
    }
}
