//
//  SearchUserTableViewCell.swift
//  MiniGames
//
//  Created by Артур on 29.01.22.
//

import Foundation

class SearchUserTableViewCell: PlayersTableViewCell {
    
    static let searchID = "SearchUserTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func setupView() {
        self.playerImage.backgroundColor = .MGBackground
        self.backgroundColor = .MGFilledButton
    }
    
}
