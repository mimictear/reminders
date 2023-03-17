//
//  NotificationService.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 17.03.2023.
//

import UserNotifications

struct NotificationData {
    let title: String?
    let body: String?
    let date: Date?
    let time: Date?
}

class NotificationService {
    
    private init() { }
    
    static func scheduleNotification(data: NotificationData) {
        let contetnt = UNMutableNotificationContent()
        contetnt.title = data.title ?? ""
        contetnt.body = data.body ?? ""
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: data.date ?? Date())
        
        if let reminderTime = data.time {
            let reminderTimeComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeComponents.hour
            dateComponents.minute = reminderTimeComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // TODO: replace 'repeats' with parameter
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: contetnt, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
