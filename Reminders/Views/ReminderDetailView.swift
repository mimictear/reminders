//
//  ReminderDetailView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var reminder: Reminder
    
    @State var editConfig = ReminderEditConfiguration()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmptyOrWhitespace
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes.bound)
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate.bound, displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Set Time", selection: $editConfig.reminderTime.bound, displayedComponents: .hourAndMinute)
                        }
                        
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }
                    .onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate {
                            editConfig.reminderDate = Date()
                        }
                    }
                    .onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .onAppear {
                editConfig = ReminderEditConfiguration(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        do {
                            let updated = try ReminderService.updateReminder(reminder, editConfiguration: editConfig)
                            if updated {
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    let data = NotificationData(title: reminder.title,
                                                                body: reminder.notes,
                                                                date: reminder.reminderDate,
                                                                time: reminder.reminderTime)
                                    NotificationService.scheduleNotification(data: data)
                                }
                            }
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//struct ReminderDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderDetailView(reminder: .constant(PreviewData.reminder))
//    }
//}
