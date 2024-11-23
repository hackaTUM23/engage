//
//  NewTryChat.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import ExyteChat
import SwiftUI

import UIKit

//It basically just gets image from assets, saves its data to disk and return file URL.
class AssetExtractor {

    static func createLocalUrl(forImageNamed name: String) -> URL? {

        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")

        guard fileManager.fileExists(atPath: url.path) else {
            guard
                let image = UIImage(named: name),
                let data = image.pngData()
            else { return nil }

            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }

        return url
    }

}

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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            ChatView(messages: messages) { draft in
                print(draft.text)
                messages.append(Message(id: "new id\(CustomChatView.num_msgs)", user: user, text: draft.text))
                CustomChatView.num_msgs += 1
            } inputViewBuilder: { textBinding, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dismissKeyboardClosure in
                Group {
                        VStack {
                            HStack {
                                TextField("Write your message", text: textBinding)
                                Button("Send") { inputViewActionClosure(.send) }
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
