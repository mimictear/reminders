//
//  ReminderListView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import SwiftUI

struct ReminderListView: View {
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail = false
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List {
            ForEach(reminders) { reminder in
                ReminderCellView(reminder: reminder, selected: isReminderSelected(reminder)) { event in
                    switch event {
                    case .onCheckChanged(let reminder, let isCompleted):
                        reminderCheckChanged(reminder, isCompleted: isCompleted)
                    case .onCellTapped(let reminder):
                        selectedReminder = reminder
                    case .onInfoTapped:
                        showReminderDetail.toggle()
                    }
                }
            }
            .onDelete(perform: deleteReminder)
        }
        .listStyle(.plain)
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {                
                try ReminderService.deleteReminder(reminder)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func reminderCheckChanged(_ reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfiguration(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
            try ReminderService.updateReminder(reminder, editConfiguration: editConfig)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
}

struct ReminderListView_Previews: PreviewProvider {
    
    private struct ReminderListViewContainer: View {
        
        @FetchRequest(sortDescriptors: [])
        private var fetchedResults: FetchedResults<Reminder>
        
        var body: some View {
            ReminderListView(reminders: fetchedResults)
        }
    }
    
    static var previews: some View {
        ReminderListViewContainer()
            .environment(\.managedObjectContext, PersistenceController.shared.persistentContainer.viewContext)
    }
}
