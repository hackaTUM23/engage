//
//  MockMessages.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import ExyteChat


let bot = User(id: "test id 3", name: "Bot", avatarURL: AssetExtractor.createFromSymbol(forImageNamed: "sparkles"), isCurrentUser: false)

let mockMessages: [Message] = [
    Message(id: "test id2", user: bot, text: "Hey! Use this chat to coordinate, e.g. meeting a couple minutes before the event starts to go in together."),
    Message(id: "test id1", user: MockUsers.users[0].chatUser!, text: "Hello, super excited to join you! Let's meet 10mins before at the main entrance?"),
]
