//
//  SelectListView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var listsFetchedResults: FetchedResults<ReminderList>
    
    @Binding var selectedList: ReminderList?
    
    var body: some View {
        List(listsFetchedResults) { list in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(list.color))
                    
                    Text(list.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedList = list
                }
                
                Spacer()
                
                if selectedList == list {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

//struct SelectListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectListView(selectList: .constant(PreviewData.list))
//            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
//    }
//}
