//
//  TintedButton.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import Foundation
import UIKit

class TintedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color.withAlphaComponent(0.1)
        self.setTitleColor(color, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
