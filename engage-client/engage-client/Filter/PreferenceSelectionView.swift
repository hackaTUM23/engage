//
//  PreferenceSelectionView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import WrappingHStack

struct PreferenceSelectionView: View {
    @EnvironmentObject var appState : AppState

    func updatePreferences(index: Int) {
        appState.preferences[index].isSelected.toggle()
    }

    
    var body: some View {
        WrappingHStack(0..<appState.preferences.count) { index in
            FilterTag(filterData: appState.preferences[index])
                .onTapGesture {
                    updatePreferences(index: index)
                }
                .padding(4)
        }
    }
}

#Preview {
    PreferenceSelectionView().environmentObject(mockStateNextActivity)
}
