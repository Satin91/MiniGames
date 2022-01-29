//
//  GestureBackground.swift
//  MiniGames
//
//  Created by Артур on 25.01.22.
//


protocol GestureBackgroundDidTapped {
    func didTapGestureBackground()
}

import UIKit

class GestureBackground: UIView {

    //MARK: Properties
    var delegate: GestureBackgroundDidTapped!
    
    
    //MARK: Overriden funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Action funcs
    @objc private func tapGesture(_ sender: UITapGestureRecognizer? = nil) {
        self.delegate.didTapGestureBackground()
    }
    
    
    //MARK: Public funcs
    public func show() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 1
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 0
        }
    }
    
    //MARK: Private funcs
    private func setupView() {
        self.backgroundColor = .MGGestureBackground
        self.alpha = 0
        self.accessibilityIdentifier = "gestureBackground"
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        self.addGestureRecognizer(tap)
    }
    

}
