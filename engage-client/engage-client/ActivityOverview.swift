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
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    UserIconView()
                        .frame(maxWidth: 60, maxHeight: 60)
                    Text("Hi \(appState.user.prename)!")
                        .font(.custom("Nunito-Bold", size: 32)).padding(.leading, 8)
                    Spacer()
                }.padding(.leading, 20)
                Group {
                    Text(welcomeText)
                        .font(.custom("Nunito-Regular", size: 14)).padding(.horizontal, 14).multilineTextAlignment(.center)
                    PreferenceSelectionView()
                }.padding()
                if !loading {
                    if appState.activities.isEmpty {
                        Spacer()
                        Text("No Activities Found.")
                        Spacer()
                    } else {
                        ForEach(appState.activities) { activity in
                            ActivityListView(activity: activity, user: appState.user).onTapGesture {
                                showDetailModal.toggle()
                            }.padding()
                            .sheet(isPresented: $showDetailModal) {
                                ActivityDetailView(activity: activity)
                            }
                            Divider()
                        }
                    }
                } else {
                    ProgressView()
                }
                Spacer()
            }
        }
        .task {
            await fetchActivities()
            loading = false
        }
    }
    
    func fetchActivities() async {
        do {
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/activities?user_id=\(appState.user.id)&preferences=\(appState.preferences.map{ $0.title}.joined(separator: "&preferences="))")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, _) = try await URLSession.shared.data(for: request)
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
