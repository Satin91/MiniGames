//
//  CreateSingleGameUser.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import Foundation
import UIKit


class CreateSingleGameUser: UIView {
    
    
    weak var controller: UIViewController!
    private var nameTextField = RegularTextField(placeholder: "Введите имя")
    private var collectionView: AvatarsCollectionView!
    private var createButton: FilledButton!
    private var avatarName: String = "user1"
    private var playerName: String = "Новый игрок"
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .MGTitle
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(frame: CGRect, presentOn: UIViewController) {
        self.init(frame: frame)
        self.controller = presentOn
        setupFrame()
        setupRadius()
        setupShadow()
        setupLabel()
        setupTextField()
        setupButton()
        setupCollectionView()
        setupConstraints()
    }
    
    var completion: ((String,String)-> Void)?
    
    func show(completion: ((String,String) -> Void)?) {
        self.controller.view.addSubview(self)
        self.completion = completion
    }
    
    
    private func setupFrame() {
        self.backgroundColor = .MGBackground
        let width: CGFloat = self.controller.view.bounds.width - (Insets.additionalHorizontalIndent * 2)
        let height: CGFloat = self.controller.view.bounds.height * 0.7
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.center = controller.view.center
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 34
        layer.shadowOpacity = 0.3
    }
    
    private func setupRadius() {
        layer.cornerRadius = Insets.standartCornerRadius
        layer.cornerCurve = .continuous
    }
    
    //MARK: UI
    private func setupTextField() {
        addSubview(nameTextField)
    }
    
    func setupLabel() {
        descriptionLabel.text = "Дайте имя новому игроку и выберите аватар."
        addSubview(descriptionLabel)
    }
    
    func setupButton() {
        createButton = FilledButton(type: .system)
        createButton.setTitle("Добавить", for: .normal)
        createButton.addTarget(self, action: #selector(createPlayerButtonTapped), for: .touchUpInside)
        addSubview(createButton)
    }
    
    @objc func createPlayerButtonTapped() {
        completion!(playerName,avatarName)
        print("asad")
        self.removeFromSuperview()
    }
    
    func setupCollectionView() {
        collectionView = AvatarsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.layer.cornerCurve  = .continuous
        collectionView.layer.cornerRadius = Insets.standartCornerRadius
        addSubview(collectionView)
    }
    
    //MARK: Constrains
    func setupConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints    = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints   = false
        createButton.translatesAutoresizingMaskIntoConstraints   = false
        
        NSLayoutConstraint.activate([
            //Label
            descriptionLabel.heightAnchor.constraint(equalToConstant: 80),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            
            // TextField
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            nameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 18),
            
            //CollectionView
            createButton.heightAnchor.constraint(equalToConstant: 44),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            
            //CollectionView
            collectionView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 18),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            collectionView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -12),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}




extension CreateSingleGameUser: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = Avatars.avatars[indexPath.row]
        self.avatarName = object
    }
}
