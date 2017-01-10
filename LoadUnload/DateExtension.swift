//
//  DateExtension.swift
//  LoadUnload
//
//  Created by Narendra Kumar Rangisetty on 1/10/17.
//  Copyright © 2017 FreeLancer. All rights reserved.
//

import Foundation

extension Date {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter
    }()
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
    
    
}

extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
    
    var ludate: String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd hh:mm a yyyy"
        if let date = self.dateFromISO8601 {
            return formatter.string(from: date)
        }else{
            return nil
        }
    }
}
