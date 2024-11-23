//
//  ActivityOverview.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import CoreLocation

struct ActivityOverview: View {
    let welcomeText = "Welcome back! Here are some activities we recommend for you."
    let user = MockUsers.users.first!
    @State private var activities = [Activity]()
    @State private var loading = true
    
    var body: some View {
        VStack {
            Group {
                Text("Hi \(user.prename)!")
                    .font(.custom("Nunito-Bold", size: 32))
                Text(welcomeText)
                    .font(.subheadline).padding()
                PreferenceSelectionView(filterModel: .init())
            }
            
            if !loading {
                if activities.isEmpty {
                    Text("No Activities Found.")
                } else {
                    List {
                        ForEach(activities) { activity in
                            ChatActivitySummaryView(activity: activity, user: user)
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
            activities = try JSONDecoder().decode([Activity].self, from: data)
            
        } catch {
            print(error)
        }
    }
}

#Preview {
    ActivityOverview()
}
