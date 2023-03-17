//
//  ReminderList+CoreDataClass.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import CoreData

@objc(ReminderList)
public class ReminderList: NSManagedObject {
    
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { $0 as? Reminder } ?? []
    }
}
