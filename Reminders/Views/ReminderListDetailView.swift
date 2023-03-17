//
//  ReminderListDetailView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import SwiftUI

struct ReminderListDetailView: View {
    
    @State private var openAddReminder = false
    @State private var title = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults:  FetchedResults<Reminder>
    
    let reminderList: ReminderList
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace
    }
    
    init(reminderList: ReminderList) {
        self.reminderList = reminderList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getReminders(by: reminderList))
    }
    
    var body: some View {
        VStack {
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Button {
                    openAddReminder.toggle()
                } label: {
                    Label("New Reminder", systemImage: "plus.circle.fill")
                        .font(.headline)
                        .labelStyle(.titleAndIcon)
                }
            }
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
                if isFormValid {
                    do {
                        try ReminderService.saveReminder(list: reminderList, title: title)
                        title = ""
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
                // TODO: show message/alert/wtf when form is invalid
            }
            //.disabled(!isFormValid)
        }
    }
}

// TODO: fix it
//struct ReminderListDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListDetailView(reminderList: PreviewData.list)
//    }
//}
