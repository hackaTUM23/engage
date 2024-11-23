//
//  FilterTag.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

struct FilterTag: View {
    var filterData: FilterData
    
    var body: some View {
        Label(filterData.title, systemImage: filterData.icon ?? "questionmark.circle")
            .font(.custom("Nunito-Regular", size: 18))
            .frame(alignment: .center)
            .padding(5)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(filterData.isSelected ? .accentColor : Color.black.opacity(0.6))
            )
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
    }
}


#Preview {
    FilterTag(filterData: .init(title: "Group Sports", icon: "sportscourt"
))
}
