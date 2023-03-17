//
//  MainView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import SwiftUI

struct MainView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var lists: FetchedResults<ReminderList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchedResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.getReminders(by: .today))
    private var todayRemindersResult
    
    @FetchRequest(fetchRequest: ReminderService.getReminders(by: .all))
    private var allRemindersResult
    
    @FetchRequest(fetchRequest: ReminderService.getReminders(by: .scheduled))
    private var scheduledRemindersResult
    
    @FetchRequest(fetchRequest: ReminderService.getReminders(by: .completed))
    private var completedRemindersResult
    
    @State private var createNewReminderPressed = false
    @State private var createNewListPressed = false
    @State private var searchText = ""
    @State private var searching = false
    @State private var statisticValues = ReminderStatisticValues()
    
    private var reminderStatisticBuilder = ReminderStatisticBuilder()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        // TODO: collapse these stuff into builder function
                        // TODO: make kinda enum for all type of cards (today, all, etc.)
                        // which would be contain icon, title, and tint color
                        NavigationLink {
                            ReminderListView(reminders: todayRemindersResult)
                        } label: {
                            ReminderStatisticView(icon: "calendar",
                                                  title: "Today",
                                                  count: statisticValues.today)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: allRemindersResult)
                        } label: {
                            ReminderStatisticView(icon: "tray.circle.fill",
                                                  title: "All",
                                                  count: statisticValues.all,
                                                  iconTintColor: .red)
                        }
                    }
                    
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: scheduledRemindersResult)
                        } label: {
                            ReminderStatisticView(icon: "calendar.circle.fill",
                                                  title: "Scheduled",
                                                  count: statisticValues.scheduled,
                                                  iconTintColor: .secondary)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: completedRemindersResult)
                        } label: {
                            ReminderStatisticView(icon: "checkmark.circle.fill",
                                                  title: "Completed",
                                                  count: statisticValues.completed,
                                                  iconTintColor: .primary)
                        }
                    }
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding([.bottom, .top])
                    
                    //RemindersListView(lists: lists)
                    RemindersListView()
                }
            }
            .sheet(isPresented: $createNewListPressed) {
                NavigationView {
                    AddNewListView(onSave: { name, color in
                        
                        do {
                            try ReminderService.saveRemainderList(name: name,
                                                                  color: color)
                        } catch {
                            print(error)
                        }
                    })
                }
            }
            .sheet(isPresented: $createNewReminderPressed) {
                NavigationView {
                    Text("Soon")
                }
            }
            .listStyle(.plain)
            .onChange(of: searchText, perform: { text in
                searching = !text.isEmptyOrWhitespace
                searchedResults.nsPredicate = ReminderService.getReminders(by: text).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchedResults)
                    .opacity(searching ? 1 : 0)
            })
            .onAppear {
                statisticValues = reminderStatisticBuilder.build(lists: lists)
            }
            .padding()
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        createNewReminderPressed.toggle()
                    } label: {
                        Label("New Reminder", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .labelStyle(.titleAndIcon)
                    }
                    
                    Button {
                        createNewListPressed.toggle()
                    } label: {
                        Text("Add List")
                            .font(.body)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.persistentContainer.viewContext)
    }
}
