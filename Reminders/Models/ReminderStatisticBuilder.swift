//
//  ReminderStatisticBuilder.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 16.03.2023.
//

import SwiftUI

enum ReminderStateType {
    case all
    case today
    case scheduled
    case completed
}

struct ReminderStatisticValues {
    var today = 0
    var all = 0
    var scheduled = 0
    var completed = 0
}

struct ReminderStatisticBuilder {
    
    func build(lists: FetchedResults<ReminderList>) -> ReminderStatisticValues  {
        let remindersArray = lists.map { $0.remindersArray }.reduce([], +)
        return ReminderStatisticValues(today: calculateTodayCount(reminders: remindersArray),
                                       all: calculateAllCount(reminders: remindersArray),
                                       scheduled: calculateScheduledCount(reminders: remindersArray),
                                       completed: calculateCompletedCount(reminders: remindersArray))
    }
    
    private func calculateTodayCount(reminders: [Reminder]) -> Int {
        reminders.reduce(0) { partialResult, reminder in
            
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        reminders.reduce(0) { partialResult, reminder in
            !reminder.isCompleted ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        reminders.reduce(0) { partialResult, reminder in
            
            let isScheduled = !reminder.isCompleted && (reminder.reminderDate != nil || reminder.reminderTime != nil)
            return isScheduled ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        reminders.reduce(0) { partialResult, reminder in
            reminder.isCompleted ? partialResult + 1 : partialResult
        }
    }
}
