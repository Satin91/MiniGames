//
//  ViewController.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit

extension UIViewController {

    
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
}
