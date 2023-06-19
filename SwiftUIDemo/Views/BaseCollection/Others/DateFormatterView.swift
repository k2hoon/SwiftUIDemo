//
//  DateFormatterView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/13.
//

import SwiftUI

extension DateFormatter {
    static let mediumDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.autoupdatingCurrent
        
        
        return dateFormatter
    }()
    
    static let mediumTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_kr")
        
        return dateFormatter
    }()
    
    static let mediumDateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        dateFormatter.locale = Locale(identifier: "ko_kr")
        
        return dateFormatter
    }()
}

/// Date Formatter
/// reference: https://developer.apple.com/documentation/foundation/dateformatter
struct DateFormatterView: View {
    let dateString = DateFormatter.mediumTimeFormatter.string(from: Date())
    var customDateString: String = ""
    
    init() {
        self.customDateString = DateFormatter.mediumDateFormatter.string(from: usingDateComponents()!)
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("\(dateString)")
            Text("\(customDateString)")
            Text("\(usingRFC3339DateFormatter())")
            Text("\(usingISO8601DateFormatter())")
            Text("\(timeSinceWithISO8601DateFormatter(since: "2021-06-15T00:58:04", from: "2021-06-13T01:04:06"))")
        }
    }
    
    func usingDateComponents() -> Date? {
        let dateComponents = DateComponents(year: 2021, month: 12, day: 31)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        
        return date
    }
    
    func usingRFC3339DateFormatter() -> String {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        /* 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time) */
        let string = "1996-12-19T16:39:57-08:00"
        let date = RFC3339DateFormatter.date(from: string)
        
        let dateString = DateFormatter.mediumDateTimeFormatter.string(from: date!)
        return dateString
    }
    
    /// In macOS 10.12 and later or iOS 10 and later, use the ISO8601DateFormatter class when working with ISO 8601 date representations.
    /// - Returns: description
    func usingISO8601DateFormatter() -> String {
        //        let ISO8601DateFormatter = DateFormatter()
        //        ISO8601DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //        ISO8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //        ISO8601DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        //
        //        let string = "2021-06-15T00:58:04"
        //        let date = ISO8601DateFormatter.date(from: string)
        //
        //        let dateString = DateFormatter.mediumDateTimeFormatter.string(from: date!)
        //        return dateString
        
        let dateFormatter = ISO8601DateFormatter()
        
        //.withSpaceBetweenDateAndTime has issue...
        dateFormatter.formatOptions = [.withFullDate,
                                       .withTime,
                                       .withDashSeparatorInDate,
                                       .withColonSeparatorInTime]
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        //let string = "2021-06-15T00:58:04+000Z"
        //let string = "2021-06-15T00:58:04.356Z"
        let string = "2021-06-15T00:58:04"
        let date = dateFormatter.date(from: string)
        
        let dateString = DateFormatter.mediumDateTimeFormatter.string(from: date!)
        return dateString
    }
    
    func timeSinceWithISO8601DateFormatter(since end: String, from start: String) -> Int {
        let dateFormat = ISO8601DateFormatter()
        dateFormat.formatOptions = [.withFullDate,
                                    .withTime,
                                    .withDashSeparatorInDate,
                                    .withColonSeparatorInTime]
        dateFormat.timeZone = TimeZone(secondsFromGMT: 0)
        let endDate = dateFormat.date(from: end)
        let startDate = dateFormat.date(from: start)
        let interval = endDate?.timeIntervalSince(startDate!)
        
        let days = Int(interval! / 86400)
        return days
    }
    
}

struct DateFormatterView_Previews: PreviewProvider {
    static var previews: some View {
        DateFormatterView()
    }
}
