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
}
