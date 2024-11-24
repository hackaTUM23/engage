//
//  Subscription.swift
//  engage-client
//
//  Created by Nikolai Madlener on 24.11.24.
//

class Subscription: Codable {
    var subscriptionID: Int?
    var user: AppUser
    var activity: Activity

    enum CodingKeys: String, CodingKey {
        case subscriptionID = "subscription_id"
        case user
        case activity
    }

    init(subscriptionID: Int? = nil, user: AppUser, activity: Activity) {
        self.subscriptionID = subscriptionID
        self.user = user
        self.activity = activity
    }
}
