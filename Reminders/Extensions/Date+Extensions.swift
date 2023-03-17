//
//  Date+Extensions.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import Foundation

extension Date {
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    var tomorrow: Date? {
        Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    var beginningOfDay: Date? {
        Calendar.current.startOfDay(for: self)
    }
}
