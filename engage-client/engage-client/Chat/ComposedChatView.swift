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
                    .shadow(radius: 12)
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
        print("Fetching...")
        do {
            guard let matchMakerId = appState.chatContext?.matchMakerId else {
                print("no matchmaker id when fetching chats")
                return
            }

            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/chats/\(matchMakerId)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print("fetch result : \(data)")
            
            // Custom date formatter for the "time" field (no timezone)
            let customDateFormatter = DateFormatter()
            customDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            customDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(customDateFormatter) // Use the custom date formatter

            // TODO: Parse the fetched messages to Message objects
            let chats = try decoder.decode([Chat].self, from: data)
            print("Received messages: \(chats)")
            let messages: [Message] = chats.map { chat in
                Message(id: String(chat.matchmaker_id), user: MockUsers.users[chat.user_id].chatUser!, createdAt: Date(), text: chat.message)
            }
            print("Received messages: \(messages)")
            appState.chatContext?.messages = messages
        } catch {
            print("Failed to fetch chats: \(error)")
        }
    }
}

struct Chat : Codable {
    let matchmaker_id: Int
    let user_id: Int
    let timestamp: String
    let message: String
}

struct ComposedChatView_Previews: PreviewProvider {
    
    static var previews: some View {
        ComposedChatView().environmentObject(mockStateNextActivity)
    }
}
