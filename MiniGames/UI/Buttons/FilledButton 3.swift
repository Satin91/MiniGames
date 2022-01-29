//
//  TintedButton.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import UIKit

@IBDesignable
class FilledButton: UIButton {
    
    enum ColorStyle {
        case standart
        case dark
    }
    
    @IBInspectable var colorStyle: CGFloat = 0 {
        willSet {
            switch newValue {
            case 0:
                standartButton()
            case 1:
                darkButton()
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    convenience init(style: ColorStyle) {
        self.init()
        switch style {
        case .standart:
            standartButton()
        case .dark:
            darkButton()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    func darkButton() {
        self.backgroundColor = .MGTitle
        self.setTitleColor(.MGBackground, for: .normal)
    }
    func standartButton() {
        self.backgroundColor = .MGFilledButton
        self.setTitleColor(.MGTitle, for: .normal)
    }
    func commonSetup() {
        self.backgroundColor = .MGFilledButton
        self.setTitleColor(.MGTitle, for: .normal)
        self.layer.cornerRadius = Insets.standartCornerRadius
        self.layer.cornerCurve = .continuous
        self.titleLabel?.font = .MGFont(size: 16, weight: .medium)
    }
}
