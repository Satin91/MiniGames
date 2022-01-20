//
//  SelectAvatarView.swift
//  MiniGames
//
//  Created by Артур on 18.01.22.
//

import Foundation
import UIKit

class SelectAvatarView: UIView {
    weak var owner: UIView!
    private var collectionView: AvatarsCollectionView!
    private var conformButton: FilledButton!
    private var completion: ((String) -> Void)?
    private var avatarName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(owner: UIView) {
        self.init()
        self.owner = owner
        setupView()
        setupCollectionView()
        setupButton()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Action funcs
    public func show(completion: ((String) -> Void)?) {
        self.completion = completion
        self.showFromRightSide(onView: owner)
    }
    
    @objc func conformButtonTapped(_ button: UIButton) {
        guard let avatar = avatarName else {
            self.closeAnimation()
            return
        }
        completion!(avatar)
        self.closeAnimation()
    }
    
    //MARK: Private funcs
    private func setupView() {
        self.backgroundColor = .white
        self.accessibilityIdentifier = "SelectAvatarView"
        let width: CGFloat = self.owner.bounds.width - (Insets.additionalHorizontalIndent * 2)
        let height: CGFloat = self.owner.bounds.height * 0.7
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func setupButton() {
        conformButton = FilledButton(style: .dark)
        conformButton.addTarget(self, action: #selector(conformButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(conformButton)
    }
    
    private func setupCollectionView() {
        collectionView = AvatarsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.layer.cornerCurve  = .continuous
        collectionView.layer.cornerRadius = Insets.standartCornerRadius
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        conformButton.translatesAutoresizingMaskIntoConstraints  = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: conformButton.topAnchor,constant: 20),
            conformButton.heightAnchor.constraint(equalToConstant: 56),
            conformButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            conformButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            conformButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
        ])
    }
}

extension SelectAvatarView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = Avatars.avatars[indexPath.row]
        removeSelection(collectionView: collectionView)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.MGSaturatedImage.cgColor
        self.avatarName = object
    }
    
    func removeSelection(collectionView: UICollectionView) {
        for row in collectionView.visibleCells {
            row.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
