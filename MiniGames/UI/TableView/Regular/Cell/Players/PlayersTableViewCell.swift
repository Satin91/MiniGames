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
    public func configureSingleUserCell(player: SingleUserModel) {
        self.selectionStyle = .none
        self.playerNameLabel.font = .MGFont(size: 16, weight: .medium)
        self.playerNameLabel.textColor = .MGTitle
        self.playerNameLabel.text = player.name
        self.playerImage.image = UIImage(named: player.avatar!)
        self.isIncludedImage.setImageColor(color: player.isParticipant == true ? .MGSaturatedImage : .MGSubTitle )
    }
    
    public func configureFriendsCell(player: NetworkUser) {
        self.selectionStyle = .none
        self.playerNameLabel.font = .MGFont(size: 16, weight: .medium)
        self.playerNameLabel.textColor = .MGTitle
        self.playerNameLabel.text = player.name
        self.playerImage.image = UIImage(named: player.avatar!)
        self.isIncludedImage.image = UIImage(systemName: "chevron.compact.right")
        self.isIncludedImage.tintColor = .MGSubTitle
//        self.isIncludedImage.setImageColor(color: player.isParticipant == true ? .MGSaturatedImage : .MGSubTitle )
    }
    
    public func configureSearchCell(userData: [String:String]) {
        self.backgroundColor = .MGFilledButton
        self.playerImage.backgroundColor = .MGBackground
        self.isIncludedImage.image = UIImage(systemName: "plus.circle.fill")
        self.isIncludedImage.tintColor = .MGTitle
        self.playerImage.image = UIImage(named: userData["avatar"]!)
        self.playerNameLabel.text = userData["name"]
    }
    
    
    // MARK: Private funcs
    private func setupImage() {
        playerImage.layer.cornerRadius = Insets.standartCornerRadius
        playerImage.backgroundColor = .MGImageBackground
        let gamePad = UIImage(named: "gamepad")
        self.isIncludedImage.image = gamePad
    }
}
