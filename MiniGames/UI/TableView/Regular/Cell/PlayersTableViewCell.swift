//
//  PlayersTableViewCell.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var isIncludedImage: UIImageView!
    
    
    // MARK: Properties
    static let id = "PlayersTableViewCell"
    
    // MARK: Overriden funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupImage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: Public funcs:
    public func configureCell(player: SingleUserModel) {
        self.isIncludedImage.image = UIImage(named: "gamepad")
        self.playerNameLabel.text = player.name
        self.playerImage.image = UIImage(named: player.avatar!)
    }
    // MARK: Private funcs
    private func setupImage() {
        playerImage.layer.cornerRadius = Insets.standartCornerRadius
        playerImage.backgroundColor = .MGImageBackground
    }
}
