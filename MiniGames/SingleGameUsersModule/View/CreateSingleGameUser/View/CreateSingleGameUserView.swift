//
//  CreateSingleGameUser.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import Foundation
import UIKit


class CreateSingleGameUserView: UIView, UITextFieldDelegate, GestureBackgroundDidTapped {

    
    
    //MARK: Properties
    private weak var owner: UIView!
    private var nameTextField = RegularTextField(type: .filled, placeholder: "Введите имя", image: nil)
    private var collectionView: AvatarsCollectionView!
    private var createButton: FilledButton!
    private var closeButton: CircleButton!
    private var completion: ((String,String)-> Void)?
    private var avatarName: String = "user1"
    private var playerName: String = "Новый игрок"
    private var gestureGrayBackground: GestureBackground!
    var descriptionLabel = RegularLabel(size: 18, weight: .regular)
    
    
    //MARK: Overriden Funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(owner: UIView) {
        self.init()
        self.owner = owner
        setupView()
        setupGestureBackground()
        setupRadius()
        setupShadow()
        setupLabel()
        setupTextField()
        setupButtons()
        setupCollectionView()
        setupConstraints()
    }
    
    
    //MARK: Action funcs
    public func show(completion: ((String,String) -> Void)?) {
        self.completion = completion
        self.gestureGrayBackground.standartShow(onView: self.owner)
        self.showFromRightSide(onView: self.owner)
    }
    
    @objc func createPlayerButtonTapped() {
        completion!(playerName,avatarName)
        self.closeAnimation()
        self.gestureGrayBackground.closeAnimation()
    }
    
    @objc func closeButtonTapped() {
        self.closeAnimation()
        self.gestureGrayBackground.closeAnimation()
    }
    
    @objc func textFieldDIdChange(_ textField: UITextField) {
        guard let text = textField.text, text != "" else {
            playerName = "Новый игрок"
            return
        }
        playerName = text
    }
    
    
    //MARK: Private funcs
    private func setupView() {
        self.backgroundColor = .white
        self.accessibilityIdentifier = "CreateSingleGameUserView"
        let width: CGFloat = self.owner.bounds.width - (Insets.additionalHorizontalIndent * 2)
        let height: CGFloat = self.owner.bounds.height * 0.7
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func setupGestureBackground() {
        gestureGrayBackground = GestureBackground(frame: owner.bounds)
        gestureGrayBackground.delegate = self
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
    
    private func setupTextField() {
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDIdChange(_:)), for: .editingChanged)
        addSubview(nameTextField)
    }
    
    private func setupLabel() {
        descriptionLabel.text = "Дайте имя новому игроку и выберите аватар."
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
    }
    
    private func setupButtons() {
        createButton = FilledButton(type: .system)
        createButton.setTitle("Добавить", for: .normal)
        createButton.addTarget(self, action: #selector(createPlayerButtonTapped), for: .touchUpInside)
        closeButton = CircleButton(side: 30, type: .close)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addSubview(createButton)
        addSubview(closeButton)
    }
    
    private func setupCollectionView() {
        collectionView = AvatarsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.layer.cornerCurve  = .continuous
        collectionView.layer.cornerRadius = Insets.standartCornerRadius
        addSubview(collectionView)
    }
    
    //MARK: Constrains
    private func setupConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints    = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints   = false
        createButton.translatesAutoresizingMaskIntoConstraints     = false
        closeButton.translatesAutoresizingMaskIntoConstraints      = false
        
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
            
            //CreateButton
            createButton.heightAnchor.constraint(equalToConstant: 44),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: Insets.textIndent),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -Insets.textIndent),
            createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            
            //CloseButton
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Insets.textIndent),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Insets.textIndent),
            
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
    
    //MARK: Delegate funcs
    func didTapGestureBackground() {
        self.gestureGrayBackground.closeAnimation()
        self.closeAnimation()
        
    }
}

extension CreateSingleGameUserView: UICollectionViewDelegate {
    
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
