//
//  ManropeFont.swift
//  MiniGames
//
//  Created by Артур on 26.12.21.
//

import Foundation
import UIKit

extension UIFont {
    
    class func MGFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .thin:
            return UIFont(name: "Manrope-Thin", size: size)!
        case .light:
            return UIFont(name: "Manrope-Light", size: size)!
        case .regular:
            return UIFont(name: "Manrope-Regular", size: size)!
        case .medium:
            return UIFont(name: "Manrope-Medium", size: size)!
        case .semibold:
            return UIFont(name: "Manrope-Semibold", size: size)!
        case .bold:
            return UIFont(name: "Manrope-Bold", size: size)!
        default:
            return .boldSystemFont(ofSize: size)
        }
    }
    
    class func MGKlasikFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Klasik-Regular", size: size)!
    }
    
}

//font: Manrope-Light
//font: Manrope-Regular
//font: Manrope-Thin
//font: Manrope-Medium
//font: Manrope-Semibold
//font: Manrope-Bold
