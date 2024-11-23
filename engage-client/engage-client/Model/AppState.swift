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
    var hasNextActivity: Bool {
        nextActivity != nil
    }
    
    init(activities: [Activity], user: AppUser, nextActivity: Activity? = nil, chatContext: ChatContext? = nil) {
        self.activities = activities
        self.user = user
        self.nextActivity = nextActivity
        self.chatContext = chatContext
    }
}
