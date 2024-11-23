//
//  ComposedChatView.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import SwiftUI
import ExyteChat

struct ComposedChatView : View {
    @State var activity: Activity
    @State var user: AppUser
    @State var messages: [Message]
    
    var body: some View {
        VStack {
            ChatActivitySummaryView(activity: activity, user: user)
            CustomChatView(messages: messages)
        }
    }
}


struct ComposedChatView_Previews: PreviewProvider {
    static var previews: some View {
        ComposedChatView(
            activity: MockActivities.activities[0],
            user: MockUsers.users[0],
            messages: mockMessages
        )
    }
}
