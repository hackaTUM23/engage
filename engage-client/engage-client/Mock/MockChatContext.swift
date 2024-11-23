//
//  MockChatContext.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

class MockChatContext {
    static func mock() -> ChatContext {
        return ChatContext(
            messages: mockMessages,
            otherUser: MockUsers.users.first!.chatUser
        )
    }
}
