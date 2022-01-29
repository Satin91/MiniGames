//
//  RegularLabel.swift
//  MiniGames
//
//  Created by Артур on 26.12.21.
//

import Foundation
import UIKit

class RegularLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    convenience init(size: CGFloat, weight: UIFont.Weight? = .regular) {
        self.init()
    //    self.textColor = .MGTitle
        self.font = .MGFont(size: size, weight: weight!)
        self.textAlignment = .left
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    
    func setupLabel() {
        self.textColor = .MGTitle
        self.font = .MGFont(size: 18, weight: .regular)
        self.textAlignment = .left
        self.numberOfLines = 0
    }

}


