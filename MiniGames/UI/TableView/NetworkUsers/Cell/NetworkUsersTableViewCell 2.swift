//
//  NetworkUsersTableViewCell.swift
//  MiniGames
//
//  Created by Артур on 23.01.22.
//

import UIKit

class NetworkUsersTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: RegularLabel!
    @IBOutlet weak var lastMessageLabel: RegularLabel!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    //MARK: Properties
    static let id = "NetworkUsersTableViewCell"
    
    
    //MARK: Overriden funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupLabels()
        setupImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Private funcs
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = Insets.standartCornerRadius
        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 20))
    }
    
    private func setupLabels() {
        userNameLabel.font = .MGFont(size: 16, weight: .medium)
        userNameLabel.textColor = .MGTitle
        lastMessageLabel.font = .MGFont(size: 14, weight: .medium)
        lastMessageLabel.textColor = .MGSubTitle
    }
    
    private func setupImage() {
        userAvatarImage.layer.cornerRadius = Insets.standartCornerRadius
        userAvatarImage.backgroundColor = .MGBackground
    }
    
}
