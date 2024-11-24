//
//  State.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import Foundation
import ExyteChat

class AppState : ObservableObject {
    @Published var activities: [Activity] = []
    @Published var user: AppUser = MockUsers.users.first!
    @Published var nextActivity: Activity?
    @Published var chatContext: ChatContext?
    @Published var messages: [Message] = []
    @Published var preferences: [FilterData] = [
        FilterData(title: "Fitness", icon: "figure.run.treadmill"),
        FilterData(title: "Woman Only", icon: "figure.stand.dress"),
        FilterData(title: "Health", icon: "figure.yoga"),
        FilterData(title: "Conversations", icon: "quote.bubble"),
//        FilterData(title: "Dancing", icon: "figure.socialdance"),
//        FilterData(title: "Board Games", icon: "gamecontroller"),
//        FilterData(title: "Ball Sports", icon: "figure.volleyball"),
//        FilterData(title: "Fighting", icon: "figure.kickboxing"),
//        FilterData(title: "Other", icon: "questionmark.circle")
    ]
    var hasNextActivity: Bool {
        nextActivity != nil
    }
    
    init(
        activities: [Activity],
        user: AppUser,
        nextActivity: Activity? = nil,
        chatContext: ChatContext? = nil) {
            self.activities = activities
            self.user = user
            self.nextActivity = nextActivity
            self.chatContext = chatContext            
        }
}
