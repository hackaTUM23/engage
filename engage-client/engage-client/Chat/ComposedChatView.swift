//
//  ComposedChatView.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import SwiftUI
import ExyteChat

struct ComposedChatView : View {
    @EnvironmentObject var appState: AppState
    @State private var timer: Timer?
    
    var body: some View {
        if let activity = appState.nextActivity {
            VStack {
                ChatActivitySummaryView(activity: activity, user: appState.user).padding()
                CustomChatView()
            }
        .onAppear {
            startFetchingChats()
        }
        .onDisappear {
            stopFetchingChats()
        }
    }
    }

    func startFetchingChats() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task {
                await fetchChats()
            }
        }
    }

    func stopFetchingChats() {
        timer?.invalidate()
        timer = nil
    }

    func fetchChats() async {
        print("Fetching chats...")
        do {
            guard let matchMakerId = appState.chatContext?.matchMakerId else {
                return
            }

            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/chats/\(matchMakerId)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            //let fetchedMessages = try JSONDecoder().decode([Message].self, from: data)
            //DispatchQueue.main.async {
            //    appState.chatContext?.messages = fetchedMessages
            //}
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

            // TODO: Parse the fetched messages to Message objects
            //let messages = try decoder.decode([Message].self, from: data)

        } catch {
            print("Failed to fetch chats: \(error)")
        }
    }
}

struct ComposedChatView_Previews: PreviewProvider {
    static var previews: some View {
        ComposedChatView().environmentObject(mockStateNextActivity)
    }
}
