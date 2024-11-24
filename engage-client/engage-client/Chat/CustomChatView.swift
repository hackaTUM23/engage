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
            messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: MockUsers.users[1].chatUser!, text: draft.text))
            CustomChatView.num_msgs += 1
            // TODO: Send message here to server endpoint
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
