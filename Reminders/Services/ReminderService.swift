//
//  ReminderService.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import UIKit
import CoreData

class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        PersistenceController.shared.persistentContainer.viewContext
    }
    
    private init() { }
    
    private static func save() throws {
        try viewContext.save()
    }
    
    // MARK: - Additional
    
    static func saveRemainderList(name: String, color: UIColor) throws {
        let list = ReminderList(context: viewContext)
        list.name = name
        list.color = color
        try save()
    }
    
    static func saveReminder(list: ReminderList, title: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = title
        list.addToReminders(reminder)
        try save()
    }
    
    @discardableResult
    static func updateReminder(_ reminder: Reminder, editConfiguration: ReminderEditConfiguration) throws -> Bool {
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfiguration.isCompleted
        reminderToUpdate.title = editConfiguration.title
        reminderToUpdate.notes = editConfiguration.notes
        reminderToUpdate.reminderDate = editConfiguration.hasDate ? editConfiguration.reminderDate : nil
        reminderToUpdate.reminderTime = editConfiguration.hasTime ? editConfiguration.reminderTime : nil
        try save()
        return true
    }
    
    static func getReminders(by list: ReminderList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", list)
        return request
    }
    
    static func getReminders(by type: ReminderStateType) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        switch type {
        case .all:
            request.predicate = NSPredicate(format: "isCompleted = false")
        case .today:
            guard let today = Date().beginningOfDay,
                  let tomorrow = today.tomorrow?.beginningOfDay
            else {
                return request
            }
            request.predicate = NSPredicate(format: "(reminderDate >= %@ AND reminderDate < %@)", today as NSDate, tomorrow as NSDate)
        case .scheduled:
            request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
        case .completed:
            request.predicate = NSPredicate(format: "isCompleted = true")
        }
        
        return request
    }
    
    static func getReminders(by searchText: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        return request
    }
    
    static func deleteReminder(_ reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
}
