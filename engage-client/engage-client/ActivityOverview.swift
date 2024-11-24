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
    @State private var showDetailModal = false

    var body: some View {
        VStack {
            HStack {
                UserIconView()
                    .frame(maxWidth: 60, maxHeight: 60)
                Text("Hi \(appState.user.prename)!")
                    .font(.custom("Nunito-Bold", size: 32))
                Spacer()
            }.padding(.leading, 20)
            Group {
                Text(welcomeText)
                    .font(.subheadline).padding()
                PreferenceSelectionView()
                    .padding()
            }
            
            if !loading {
                if appState.activities.isEmpty {
                    Text("No Activities Found.")
                } else {
                    List {
                        ForEach(appState.activities) { activity in
                            ActivityListView(activity: activity, user: appState.user)
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
        .sheet(isPresented: $showDetailModal) {
            ActivityDetailView()
        }
    }
    
    func fetchActivities() async {
        do {
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/activities/activities")!
            let (data, _) = try await URLSession.shared.data(from: url)
            // Convert the raw data to a string for debugging
            if let dataString = String(data: data, encoding: .utf8) {
                print("Received data as string: \(dataString)")
            } else {
                print("Failed to convert data to string")
            }
            // Custom date formatter for the "time" field (no timezone)
            let customDateFormatter = DateFormatter()
            customDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            customDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(customDateFormatter) // Use the custom date formatter

            
            appState.activities = try decoder.decode([Activity].self, from: data)
            
        } catch {
            print(error)
        }
    }
}

#Preview {
    ActivityOverview().environmentObject(mockStateNoNextActivity)
}
