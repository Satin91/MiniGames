//
//  GridCollectionView.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import UIKit
import SwiftUI

class AvatarsCollectionView: UICollectionView {
    
    
    // MARK: Properties
    static let id = "GridCollectionViewCell"
    var layout = UICollectionViewFlowLayout()
    
    
    // MARK: Overriden funcs
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Public funcs:
    public func cell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: AvatarsCollectionView.id, for: indexPath)
        return cell
    }
    
    
    // MARK: Private funcs
    private func setupCollectionView() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: AvatarsCollectionView.id)
        collectionViewLayout = createLayout()
        isPagingEnabled = true
        dataSource = self
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            
            let spacing: CGFloat = 15
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)) )
            
            
            // Группа
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1.0) ) , subitem: item, count: 3)
                                                                     
                                                                     
            horizontalGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(spacing)
            
            // Группа для групп
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.bounds.width - (spacing * 2) )), subitem: horizontalGroup, count: 3)
            verticalGroup.interItemSpacing =  NSCollectionLayoutSpacing.fixed(spacing)
            verticalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
        
        return layout
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
        cell.backgroundView = avatar
        //cell.addSubview(avatar)
        
        return cell
    }
}
