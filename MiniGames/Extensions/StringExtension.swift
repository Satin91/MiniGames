//
//  StringExtension.swift
//  MiniGames
//
//  Created by Артур on 29.01.22.
//

import Foundation

extension String {
    
    func safeEmail() -> String? {
        guard self != "" else { return nil }
        return self.lowercased().replacingOccurrences(of: " ", with: "")
    }
}
