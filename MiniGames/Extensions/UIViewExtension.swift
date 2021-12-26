//
//  UIViewExtension.swift
//  MiniGames
//
//  Created by Артур on 26.12.21.
//

import UIKit
import SwiftUI

extension UIView {
    
    //MARK: Show animations
    func showFromRightSide(onView: UIView) {
        
        for view in onView.subviews {
            if view.accessibilityIdentifier == self.accessibilityIdentifier {
                return
            }
        }
        
        onView.addSubview(self)
        self.alpha = 1
        
        let startCenter = CGPoint(x: onView.bounds.width, y: onView.center.y + -self.bounds.height / 2)
        self.center = startCenter
        let angle: CGFloat = -(CGFloat.pi / 60)
        self.layer.anchorPoint = self.bounds.origin
        self.transform = self.transform.rotated(by: angle)
        
        let duration: TimeInterval = 0.16
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn) {
            self.center.x = onView.center.x + -self.bounds.width / 2
            
        } completion: { _ in

            UIView.animate(withDuration: duration * 0.4, delay: 0, options: .curveEaseOut) {
                self.transform = CGAffineTransform(rotationAngle: -angle)
            } completion: { _ in
                UIView.animate(withDuration: duration * 0.8, delay: 0, options: .curveEaseInOut) {
                    self.transform = CGAffineTransform(rotationAngle: 0)
                }
            }
        }
    }
    
    
    //MARK: Close animations
    func closeAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

