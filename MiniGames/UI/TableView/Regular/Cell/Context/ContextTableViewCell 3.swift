//
//  ContextTableViewCell.swift
//  MiniGames
//
//  Created by Артур on 21.01.22.
//

import UIKit

class ContextTableViewCell: UITableViewCell {

    
    //MARK: Outlets
    @IBOutlet weak var contextLabel: RegularLabel!
    @IBOutlet weak var contextImage: UIImageView!
    
    
    //MARK: Properties
    static let id = "ContextTableViewCell"
    let separator = UIView()
    
    //MARK: Overriden funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        deawSeparator()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    //MARK: Private funcs
    private func setupView() {
        backgroundColor = .white
        contextLabel.font = .MGFont(size: 12, weight: .regular)
    }
    
    private func deawSeparator() {
        self.addSubview(separator)
        separator.backgroundColor = .MGBackground
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
