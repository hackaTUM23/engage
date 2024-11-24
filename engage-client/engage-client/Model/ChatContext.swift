//
//  ChatContext.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import ExyteChat

class ChatContext {
    var messages: [Message] = []
    var otherUser: User?
    var matchMakerId: Int?
    
    init(messages: [Message], otherUser: User? = nil) {
        self.messages = messages
        self.otherUser = otherUser
    }
}
