//
//  State.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import Foundation

class AppState : ObservableObject {
    @Published var activities: [Activity] = []
    @Published var user: AppUser = MockUsers.users.first!
    @Published var nextActivity: Activity?
    @Published var chatContext: ChatContext?
    @Published var preferences: [FilterData] = [
        // todo - update with:
        // Fitness
        // Woman Only
        // Health (yoga, chi gong, etc)
        // Ratschen
        // Dancing
        // Ball Sports
        // Fighting Sports
        
        FilterData(title: "Fitness", icon: "figure.run.treadmill"),
        FilterData(title: "Woman Only", icon: "figure.stand.dress"),
        FilterData(title: "Health", icon: "figure.yoga"),
        FilterData(title: "Conversations", icon: "quote.bubble"),
        FilterData(title: "Dancing", icon: "figure.socialdance"),
        FilterData(title: "Board Games", icon: "gamecontroller"),
        FilterData(title: "Ball Sports", icon: "figure.volleyball"),
        FilterData(title: "Fighting", icon: "figure.kickboxing"),
        FilterData(title: "Other", icon: "questionmark.circle")
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
