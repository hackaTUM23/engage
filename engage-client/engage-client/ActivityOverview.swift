//
//  ActivityOverview.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import CoreLocation

struct ActivityOverview: View {
    @EnvironmentObject var appState: AppState
    
    let welcomeText = "Welcome back! Here are some activities we recommend for you."
    @State private var loading = true

    var body: some View {
        VStack {
            Group {
                Text("Hi \(appState.user.prename)!")
                    .font(.custom("Nunito-Bold", size: 32))
                Text(welcomeText)
                    .font(.subheadline).padding()
                PreferenceSelectionView(filterModel: .init())
            }
            
            if !loading {
                if appState.activities.isEmpty {
                    Text("No Activities Found.")
                } else {
                    List {
                        ForEach(appState.activities) { activity in
                            ChatActivitySummaryView(activity: activity, user: appState.user)
                        }
                    }
                }
            } else {
                ProgressView()
            }
            Spacer()
        }.task {
            await fetchActivities()
            loading = false
        }
    }
    
    func fetchActivities() async {
        do {
            try await Task.sleep(for: .seconds(10))
            let url = URL(string: "https://34.141.34.184:8080/activities/activities")!
            let (data, _) = try await URLSession.shared.data(from: url)
            appState.activities = try JSONDecoder().decode([Activity].self, from: data)
            
        } catch {
            print(error)
        }
    }
}

#Preview {
    ActivityOverview().environmentObject(mockStateNoNextActivity)
}
