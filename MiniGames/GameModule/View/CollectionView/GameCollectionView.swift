//
//  GameCollectionView.swift
//  MiniGames
//
//  Created by Артур on 20.12.21.
//

import UIKit

extension GameViewController {
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PlayersCell")
        collectionView.isUserInteractionEnabled = false
    }
    
    func setupCollectionViewLayout() {
        self.topConstraint.constant = self.topbarHeight
        let layout = UICollectionViewFlowLayout()
        let size = collectionView.bounds.width / 3
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = size * 2
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: size, bottom: 0, right: size)
        collectionView.collectionViewLayout = layout
    }
}
