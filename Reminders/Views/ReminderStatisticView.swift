//
//  ReminderStatisticView.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 16.03.2023.
//

import SwiftUI

struct ReminderStatisticView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let icon: String
    let title: String
    let count: Int?
    var iconTintColor: Color = .blue
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundColor(iconTintColor)
                        .font(.title)
                    
                    Text(title).opacity(0.8)
                }
                
                Spacer()
                
                if let count {
                    Text("\(count)").font(.largeTitle)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.darkGray : Color.lightWhite)
            .foregroundColor(colorScheme == .dark ? Color.lightWhite : Color.darkGray)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

struct ReminderStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases,
                id: \.self,
                content: ReminderStatisticView(icon: "calendar",
                                               title: "Today",
                                               count: 12)
                    .preferredColorScheme
        )
    }
}
