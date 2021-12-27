//
//  TintedButton.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import UIKit

class FilledButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        self.backgroundColor = .MGFilledButton
        self.setTitleColor(.MGTitle, for: .normal)
        self.layer.cornerRadius = Insets.standartCornerRadius
        self.layer.cornerCurve = .continuous
        self.titleLabel?.font = .MGFont(size: 16, weight: .medium)
    }
}
