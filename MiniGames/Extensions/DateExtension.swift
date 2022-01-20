//
//  DateExtension.swift
//  MiniGames
//
//  Created by Артур on 19.01.22.
//

import Foundation

extension Date {
    
    func getStringDate(fromDate: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy-HH:mm:ss-SSS"
        let stringDate = dateFormatter.string(from: fromDate)
        return stringDate
    }
    
    func dateFromFirebase(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MM-dd-yyyy-HH:mm:ss-SSS"
        let date = dateFormatter.date(from:stringDate)
        return date!
    }
}
