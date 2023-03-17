//
//  RemindersApp.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import SwiftUI
import UserNotifications

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, PersistenceController.shared.persistentContainer.viewContext)
        }
    }
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if granted {
                // TODO
            } else {
                // TODO
            }
        }
    }
}
