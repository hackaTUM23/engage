//
//  PreferenceSelectionView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import WrappingHStack

struct PreferenceSelectionView: View {
    @ObservedObject var filterModel: FilterModel
    
    var body: some View {
        WrappingHStack(0..<filterModel.data.count) { index in
            FilterTag(filterData: filterModel.data[index])
                .onTapGesture {
                    filterModel.toggleFilter(at: index)
                }
                .padding(4)
        }
        Spacer()
    }
}

class FilterModel: NSObject, ObservableObject {
    var data = [
        FilterData(title: "Group Sports", icon: "sportscourt"),
        FilterData(title: "Concerts", icon: "music.note"),
        FilterData(title: "Movies", icon: "film"),
        FilterData(title: "Books", icon: "book"),
        FilterData(title: "Art", icon: "paintbrush"),
        FilterData(title: "Board Games", icon: "gamecontroller"),
        FilterData(title: "Other", icon: "questionmark.circle")
    ]
    
    @Published var selection = [FilterData]()
    
    func toggleFilter(at index: Int) {
        guard index >= 0 && index < data.count else { return }
        data[index].isSelected.toggle()
        refreshSelection()
    }
    
    func clearSelection() {
        for index in 0..<data.count {
            data[index].isSelected = false
        }
        refreshSelection()
    }
    
    private func refreshSelection() {
        let result = data.filter{ $0.isSelected }
        withAnimation {
            selection = result
        }
    }
}

#Preview {
    PreferenceSelectionView(filterModel: .init())
}
