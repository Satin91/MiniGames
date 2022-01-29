//
//  CircleButton.swift
//  MiniGames
//
//  Created by Артур on 26.12.21.
//

import Foundation
import UIKit

class CircleButton: UIButton {
    
    private var side: CGFloat = 0
    
    enum ButtonType {
        case close
        case action
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(side: CGFloat, type: ButtonType) {
        self.init(frame: CGRect(x: 0, y: 0, width: side, height: side))
        self.side = side
        commonSetup()
        switch type {
        case .close:
            setupCloseType()
        case .action:
            setupActionType()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func commonSetup() {
        layer.cornerRadius = side / 2
        backgroundColor = .MGFilledButton
    }
    
    func setupCloseType() {
        backgroundColor = .MGSecondaryImageBackground
        setImage(UIImage(systemName: "xmark") , for: .normal)
        tintColor = .MGTitle
    }
    
    func setupActionType() {
        
    }
}
