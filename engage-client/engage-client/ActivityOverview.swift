//
//  ActivityOverview.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

struct ActivityOverview: View {
    @EnvironmentObject var appState: AppState
    
    let welcomeText = "Welcome back! Here are some activities we recommend for you."
    
    
    var body: some View {
        VStack {
            Group {
                Text("Hi \(appState.user.prename)!")
                    .font(.custom("Nunito-Bold", size: 32))
                Text(welcomeText)
                    .font(.subheadline).padding()
                PreferenceSelectionView(filterModel: .init())
            }
            List {
                ForEach(appState.activities) { activity in
                    ChatActivitySummaryView(activity: activity, user: appState.user)
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    ActivityOverview().environmentObject(mockStateNoNextActivity)
}
