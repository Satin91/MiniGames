//
//  RegularTableView.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import Foundation
import UIKit

class RegularTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    func setupTableView() {
        self.separatorColor = .MGSaturatedImage.withAlphaComponent(0.4)
        self.separatorStyle = .singleLine
        self.backgroundColor = .clear
        self.rowHeight = 60
    }
}
