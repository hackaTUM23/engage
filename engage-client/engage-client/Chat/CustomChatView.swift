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
    
    var body: some View {
        ChatView(messages: messages) { draft in
            print(draft.text)
            messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: bot, text: draft.text))
            CustomChatView.num_msgs += 1
        }
//        messageBuilder: { message, positionInUserGroup, positionInCommentsGroup, showContextMenuClosure, messageActionClosure, showAttachmentClosure in
//            VStack {
//                Text(message.text)
////                if !message.attachments.isEmpty {
////                    ForEach(message.attachments, id: \.id) { at in
////                        AsyncImage(url: at.thumbnail)
////                    }
////                }
//            }
//        }
        inputViewBuilder: { textBinding, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dismissKeyboardClosure in
            Group {
                HStack {
                    TextField("Start a conversation", text: textBinding)
                        .padding(7)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    Button() { inputViewActionClosure(.send) } label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    }
                }.padding(.top)
            }
        }
    }
}

#Preview {
    CustomChatView(messages: mockMessages)
}
