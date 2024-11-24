//
//  AcceptEventModalView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

struct AcceptEventModalView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State var activity: Activity?
    @State private var loading = true
    @State private var acceptLoading = false
    
    var body: some View {
        VStack {
            SheetPill()
            if loading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if let activity = activity {
                Text("Get going!").font(.custom("Nunito-Bold", size: 24)).padding()
                Image("vincent")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
                ChatActivitySummaryView(activity: activity, user: appState.user)
                Spacer()
                HStack {
                    Button("Tomorrow, I promise", role: .cancel) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .disabled(acceptLoading)
                    Button {
                        Task {
                            await accept()
                        }
                    } label: {
                        if acceptLoading {
                            ProgressView()
                        } else {
                            Text("Let's Go!")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .disabled((activity == nil) || acceptLoading)
                }
            } else {
                Text("No activity available")
                    .font(.custom("Nunito-Bold", size: 24))
                    .padding()
            }
        }
        .task {
            await fetchActivity()
            loading = false
        }
    }
    
    func accept() async {
        acceptLoading = true
        appState.nextActivity = activity
        await matchmaking()
        acceptLoading = false
        dismiss()
    }
    
    func fetchActivity() async {
        do {
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/subscriptions/find_matching_subscription?user_id=\(appState.user.id)&preferences=\(appState.preferences.map{$0.title}.joined(separator: "&preferences="))")!
            
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            activity = try decoder.decode(Activity.self, from: data)
        } catch {
            print(error)
        }
    }
    
    func matchmaking() async {
        print("Matchmaking")
        do {
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/matchmaker/accept_match")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let requestBody: [String: Any] = [
                "users": [0, 1],
                "activity_id": appState.nextActivity?.id ?? 0
            ]
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let matchmakerId = try JSONDecoder().decode(Int.self, from: data)
            appState.chatContext?.matchMakerId = matchmakerId
        } catch {
            print(error)
        }
    }
    
}

#Preview {
    AcceptEventModalView(activity: MockActivities.activities[0])
}
