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
        Label(filterData.title, systemImage: "")
            .font(.callout)
            .padding(4)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(filterData.isSelected ? .accentColor : Color.black.opacity(0.6))
            )
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
    }
}
