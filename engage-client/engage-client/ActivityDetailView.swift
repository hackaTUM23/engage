//
//  ActivityDetailView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 24.11.24.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    var activity: Activity
    @State var acceptLoading = false

    var body: some View {
        VStack {
            SheetPill()
            ChatActivitySummaryView(activity: activity, user: appState.user)
                .padding()
            Text("Sign up for this event and we will notify you as soon as someone else joins.").multilineTextAlignment(.center).padding(.horizontal)
            Text("You can then hold each other accountable to actually show up.").multilineTextAlignment(.center)
            Spacer()
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
            .disabled(acceptLoading)
        }
//        .background(Color(UIColor.systemGray6))
    }
    
    func accept() async {
        print("dismissing")
        acceptLoading = true
//        appState.nextActivity = mainMockActivity
//        await matchmaking()
        /*ppState.chatContext = ChatContext(messages: [], otherUser: MockUsers.users[0].chatUser!, matchMakerId: 1)*/
        acceptLoading = false
        dismiss()
//        appState.nextActivity = mainMockActivity
    }
    
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
            appState.chatContext?.matchMakerId = matchmakerId
        } catch {
            print(error)
        }
    }
}

#Preview {
    ActivityDetailView(activity: MockActivities.activities[0])
}
