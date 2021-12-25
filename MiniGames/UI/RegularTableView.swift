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
        //fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        self.separatorColor = .MGBackground
        self.backgroundColor = .clear
    }
}
