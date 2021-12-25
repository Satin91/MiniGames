//
//  NavigationBarExtension.swift
//  MiniGames
//
//  Created by Артур on 25.12.21.
//

import Foundation
import UIKit


extension UINavigationItem {
    enum ButtonPosition {
        case left
        case right
    }
    func setMGButtonItem(imageName: String,position: ButtonPosition, target: UIViewController, action: Selector) {
        let size = target.navigationController!.navigationBar.bounds.height
        let customView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        customView.layer.cornerRadius = size / 2
        customView.backgroundColor = .MGSecondaryImageBackground
        
        
        let button = UIButton(type: .system)
        button.frame = customView.bounds
        button.setImage(UIImage(systemName: imageName) , for: .normal)
        button.tintColor = .MGTitle
        button.addTarget(target, action: action, for: .touchUpInside)
        customView.addSubview(button)
        
        switch position {
        case .left:
            let leftBarButtonItem = UIBarButtonItem(customView: customView)
            self.leftBarButtonItem = leftBarButtonItem
        case .right:
            let rightBarButtonItem = UIBarButtonItem(customView: customView)
            self.rightBarButtonItem = rightBarButtonItem
        }
        
    }
    
}
