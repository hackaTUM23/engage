//
//  NewTryChat.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import ExyteChat
import SwiftUI
import UIKit


struct CustomChatView: View {
    @EnvironmentObject var appState: AppState
    
   // @Binding var messages: [Message]
    static var num_msgs: Int = 0
    
    func handleTextInput(draft: DraftMessage) {
        print(draft.text)
        if var messages = appState.chatContext?.messages {
            messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: appState.user.chatUser!, text: draft.text))
            CustomChatView.num_msgs += 1
            Task {
                await send_message(msg: draft.text)
            }
        } else {
            print("messages is nil, cannot add message")
        }
    }
    
    var body: some View {
        if let messages = appState.chatContext?.messages {
            ChatView(messages: messages, didSendMessage: handleTextInput)  { textBinding, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dismissKeyboardClosure in
                HStack {
                    TextField("Type message", text: textBinding)
                        .padding(7)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    Button() { inputViewActionClosure(.send) } label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    }
                }
                .padding()
            }
        } else {
            Text("TODO: add spinner loading chat messages")
        }
    }

    func send_message(msg: String) async {
        print("send_message")
        do {
            guard let matchMakerId = appState.chatContext?.matchMakerId else {
                return
            }
            
            let url = URL(string: "https://engage-api-dev-855103304243.europe-west3.run.app/chats/send_message")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let requestBody: [String: Any] = [
                "matchmaker_id": matchMakerId,
                "user_id": appState.user.id,
                "timestamp": Date().timeIntervalSince1970,
                "message": msg
            ]
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            
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



struct CustomChatView_Previews: PreviewProvider {
    static let myEnvObject = AppState(
        activities: [],
        user: MockUsers.users.first!,
        nextActivity: MockActivities.activities.first!,
        chatContext: MockChatContext.mock(),
        preferences: []
    )
    
    static var previews: some View {
        CustomChatView()
                .environmentObject(myEnvObject)
        }
    
}
