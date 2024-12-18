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
    @State var otherUser: AppUser?
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
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
                Text("\(otherUser?.prename ?? "") \(otherUser?.surname ?? "Someone") invited you to join him!").font(.custom("Nunito-Regular", size: 18))
                Text("\(otherUser?.age ?? 0) years old").font(.custom("Nunito-Regular", size: 14))
                Text("Interested in \(otherUser?.interests.joined(separator: ", ") ?? "")").font(.custom("Nunito-Regular", size: 14))
                ChatActivitySummaryView(activity: activity, user: appState.user).padding()
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
        .background(Color(UIColor.systemGray6))
        .task {
            activity = mainMockActivity
//            await fetchActivity()
            otherUser = MockUsers.users[1]
            
            loading = false
        }
    }
    
    func accept() async {
        acceptLoading = true
        appState.nextActivity = activity
        await matchmaking()
        appState.chatContext = ChatContext(messages: [], otherUser: MockUsers.users[1].chatUser, matchMakerId: 1)
        acceptLoading = false
        dismiss()
    }
    
    func fetchActivity() async {
        do {
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/subscriptions/find_matching_subscription?user_id=\(appState.user.id ?? 0)&preferences=\(appState.preferences.map{$0.title}.joined(separator: "&preferences="))")!
            
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let sub = try decoder.decode(Subscription.self, from: data)
            activity = sub.activity
            otherUser = sub.user
        } catch {
            print(error)
        }
    }
    
//    func fetchUser() async {
//        do {
//            let userId = 1
//            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/users/\(userId)")!
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            otherUser = try decoder.decode(AppUser.self, from: data)
//        } catch {
//            print(error)
//        }
//    }
    
    func matchmaking() async {
        print("Matchmaking")
        do {
            guard let activityId = appState.nextActivity?.id else {
                throw URLError(.badURL)
            } 
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/matchmaker/accept_match?users=1&users=2&activity_id=\(activityId)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Convert the raw data to a string for debugging
            if let dataString = String(data: data, encoding: .utf8) {
                print("Received data as string: \(dataString)")
            } else {
                print("Failed to convert data to string")
            }
            
            
            let matchmakerId = try JSONDecoder().decode(Int.self, from: data)
            appState.chatContext = .init(messages: [])
            appState.chatContext!.matchMakerId = matchmakerId
        } catch {
            print(error)
        }
    }
    
}

#Preview {
    AcceptEventModalView(activity: MockActivities.activities[0])
}
