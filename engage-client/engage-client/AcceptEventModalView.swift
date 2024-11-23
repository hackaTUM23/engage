//
//  AcceptEventModalView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import CoreLocation

struct AcceptEventModalView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var activity: Activity
    @State private var loading = true
 
    var body: some View {
        VStack {
            if !loading {
                Text("Get going!").font(.custom("Nunito-Bold", size: 24)).padding()
                Image("spriessen")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
                ChatActivitySummaryView(activity: MockActivities.activities[0], user: MockUsers.users[0])
                Spacer()
                HStack {
                    Button("Tomorrow, I promise", role: .cancel) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .frame(maxWidth: .infinity)
                    Button("Let's Go!") {
                        accept()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            } else {
                ProgressView()
            }
        }.task {
            await fetchActivity()
            loading = false
        }
    }
    
    func accept() {
        // todo - update appState accordingly
        dismiss()
    }
    
    func fetchActivity() async { // todo - pass uid and filters
        do {
            try await Task.sleep(for: .seconds(10))
            let url = URL(string: "https://34.141.34.184:8080/subscriptions/find_matching_subscription")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let requestBody: [String: Any] = [
                "user_id": 1, // todo actual uid
                "preferences": ["football", "basketball"] // todo actual filters
            ]
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            activity = try JSONDecoder().decode(Activity.self, from: data)
        } catch {
            print(error)
        }
    }
}

#Preview {
    AcceptEventModalView(activity: MockActivities.activities[0])
}
