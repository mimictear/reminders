//
//  ReminderList+CoreDataProperties.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import UIKit
import CoreData

extension ReminderList {
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<ReminderList> {
        NSFetchRequest<ReminderList>(entityName: "ReminderList")
    }
    
    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var reminders: NSSet?
}

extension ReminderList {
    
}

extension ReminderList: Identifiable {
    
    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)
    
    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)
    
    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)
    
    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)
}
