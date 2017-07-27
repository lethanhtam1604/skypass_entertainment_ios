//
//  Date.swift
//  litAPP
//
//  Created by Luu Nguyen on 3/5/17.
//  Copyright © 2017 ID8. All rights reserved.
//

import Foundation

extension Date {
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
        
        static let dateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter
        }()
        
        static let timeFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm:ss a"
            return formatter
        }()
    }
    
    var iso8601: String { return Formatter.iso8601.string(from: self) }

    var dateString: String { return Formatter.dateFormat.string(from: self) }
    
    var timeString: String { return Formatter.timeFormat.string(from: self) }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
}
