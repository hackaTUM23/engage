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


    @State var messages: [Message] = []
    static var num_msgs: Int = 0
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("adding message")
            messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: bot, text: "Hello, I'm a bot. How can I help you today?"))
            CustomChatView.num_msgs += 1
        }
    }
    
    func handleTextInput(draft: DraftMessage) {
        print(draft.text)
        messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: MockUsers.users[1].chatUser!, text: draft.text))
        CustomChatView.num_msgs += 1
    }
    
    var body: some View {
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
    }
}

#Preview {
    CustomChatView(messages: mockMessages)
}
