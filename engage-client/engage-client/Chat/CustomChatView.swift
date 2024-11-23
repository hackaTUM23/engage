//
//  NewTryChat.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import ExyteChat
import SwiftUI

import UIKit

let user = User(id: "test id", name: "Homie 1", avatarURL: nil, isCurrentUser: true)
let otheruser = User(id: "test id 2", name: "Homie 2", avatarURL: AssetExtractor.createLocalUrl(forImageNamed: "spriessen"), isCurrentUser: false)
let bot = User(id: "test id 3", name: "Bot", avatarURL: nil, isCurrentUser: false)

struct CustomChatView: View {

    @State var messages: [Message] = [
        Message(id: "test id0", user: user, text: "Hello, world!"),
        Message(id: "test id1", user: otheruser, text: "Hello, other!"),
        Message(id: "test id2", user: bot, text: "Hello, bot!"),
    ]
    static var num_msgs: Int = 0
    
    var body: some View {
            ChatView(messages: messages) { draft in
                if (draft.text == "")
                    { return }
                print(draft.text)
                messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: user, text: draft.text))
                CustomChatView.num_msgs += 1
            } inputViewBuilder: { textBinding, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dismissKeyboardClosure in
                Group {
                        VStack {
                            HStack {
                                TextField("Write your message", text: textBinding)
                                Button() { inputViewActionClosure(.send) } label: {
                                    Image(systemName: "paperplane.fill")
                                        .imageScale(.large)
                                        .foregroundStyle(.tint)
                                }
                                
                                    
                            }
                        }

                    }
                }
            
        .padding()
    }
}

#Preview {
    CustomChatView()
}
