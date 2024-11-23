//
//  MockState.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

let mockStateNextActivity: AppState = .init(
    activities: [],
    user: MockUsers.users.first!,
    nextActivity: MockActivities.activities.first!,
    chatContext: MockChatContext.mock(),
    preferences: []
    )

let mockStateNoNextActivity: AppState = .init(
    activities: MockActivities.activities,
    user: MockUsers.users.first!,
    nextActivity: nil,
    chatContext: nil,
    preferences: []
)
