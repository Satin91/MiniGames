//
//  UIViewControllerExtension.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

extension UIViewController {
    
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func showContextMenu(holderView: UIView, data: [ContextDataModel], tappedOnCell: ((IndexPath) -> Void)?) {
        let menu = ContextMenu(holderView: holderView, data: data)
        menu.show(onView: self.view, completion: tappedOnCell)
    }
    
}
