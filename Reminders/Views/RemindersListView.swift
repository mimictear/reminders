//
//  RemindersListView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import SwiftUI

struct RemindersListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(sortDescriptors: [])
    private var lists: FetchedResults<ReminderList>        
    
    var body: some View {
        NavigationStack {
            if lists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(lists) { list in
                    NavigationLink(value: list) {
                        VStack {
                            ReminderListCellView(list: list)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                                .foregroundColor(colorScheme == .dark ? Color.lightWhite : Color.darkGray)
                            Divider()
                        }
                    }
                    .listRowBackground(colorScheme == .dark ? Color.darkGray : Color.lightWhite)
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: ReminderList.self) { list in
                    ReminderListDetailView(reminderList: list)
                        .navigationTitle(list.name)
                }
            }
        }
    }
}


// TODO: fix it
//struct RemindersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListView()
//    }
//}
