//
//  ReminderListCellView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import SwiftUI

struct ReminderListCellView: View {
    
    let list: ReminderList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(Color(list.color))
            
            Text(list.name)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.4)
                .padding([.trailing], 10)
        }
    }
}

//struct ReminderListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListCellView(list: PreviewData.list)
//    }
//}
