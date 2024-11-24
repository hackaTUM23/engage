import ExyteChat
import SwiftUI

import UIKit

let botOld = User(id: "test id 3", name: "Bot", avatarURL: AssetExtractor.createFromSymbol(forImageNamed: "sparkles"), isCurrentUser: false)

let mockMessagesOld: [Message] = [
    Message(id: "test id2", user: bot, text: "Hey! Use this chat to coordinate, e.g. meeting a couple minutes before the event starts to go in together."),
    Message(id: "test id1", user: MockUsers.users[1].chatUser!, text: "Hello, super excited to join you! Let's meet 10mins before at the main entrance?"),
]

struct CustomChatView: View {


    @State var messages: [Message] = mockMessages
    static var num_msgs: Int = 0
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("adding message")
            messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: botOld, text: "Hello, I'm a bot. How can I help you today?"))
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
    CustomChatView(messages: mockMessagesOld)
}
