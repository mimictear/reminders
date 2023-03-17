//
//  ReminderCellView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import SwiftUI

enum ReminderCellViewEvents {
    case onCheckChanged(Reminder, Bool)
    case onCellTapped(Reminder)
    case onInfoTapped
}

struct ReminderCellView: View {
    
    @State private var checked = false
    
    @ObservedObject var reminder: Reminder
    
    let selected: Bool
    let action: (ReminderCellViewEvents) -> Void
    
    private let delay = Delay(seconds: 1)
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    delay.cancel()
                    delay.performWork {
                        action(.onCheckChanged(reminder, checked))
                        reminder.objectWillChange.send()
                    }                    
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "empty")
                
                if let notes = reminder.notes,
                   !notes.isEmptyOrWhitespace {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            
            Spacer()
            
            Image(systemName: "info.circle.fill")
                .opacity(selected ? 1 : 0)
                .onTapGesture {
                    action(.onInfoTapped)
                }
        }
        .onAppear {
            checked = reminder.isCompleted
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action(.onCellTapped(reminder))
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
}

// TODO: fix this
//struct ReminderCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        let reminder = Reminder()
//        ReminderCellView(reminder: reminder,
//                         selected: true,
//                         action: { _ in })
//    }
//}
