//
//  ActivityOverview.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

struct ActivityOverview: View {
    let welcomeText = "Welcome back! Here are some activities we recommend for you."
    let user = MockUsers.users.first!
    var body: some View {
        VStack {
            Text("Activity Overview")
                .font(.largeTitle)
            Text(welcomeText)
                .font(.subheadline).padding()
            PreferenceSelectionView(filterModel: .init())
            List {
                ForEach(MockActivities.activities) { activity in
                    ChatActivitySummaryView(activity: activity, user: user)
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    ActivityOverview()
}
