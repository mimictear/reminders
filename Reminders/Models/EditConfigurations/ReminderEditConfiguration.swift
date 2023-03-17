//
//  ReminderEditConfiguration.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import Foundation

struct ReminderEditConfiguration {
    var title: String = ""
    var notes: String?
    var isCompleted = false
    var hasDate = false
    var hasTime = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init() { }
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate ?? Date()
        reminderTime = reminder.reminderTime ?? Date()
        hasDate = reminderDate != nil
        hasTime = reminderTime != nil
    }
}
