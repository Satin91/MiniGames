//
//  GridCollectionView.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import UIKit
import SwiftUI

class AvatarsCollectionView: UICollectionView {
    
    static let id = "GridCollectionViewCell"

    var layout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        setupCollectionView()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        let spacing: CGFloat = 15
        let side = self.bounds.width / 3 - (spacing * 1.5)
        layout.itemSize = CGSize(width: side, height: side)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    func setupCollectionView() {
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: AvatarsCollectionView.id)
        self.collectionViewLayout = self.layout
        self.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

extension AvatarsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Avatars.avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarsCollectionView.id, for: indexPath)
        cell.layer.cornerRadius = 16
        cell.layer.cornerCurve = .continuous
        let avatarObject = Avatars.avatars[indexPath.row]
        let avatar = UIImageView(image: UIImage(named: avatarObject))
        avatar.frame = cell.bounds
        cell.backgroundColor = .MGImageBackground
        cell.addSubview(avatar)
        
        return cell
    }
}
