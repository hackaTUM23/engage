//
//  ChatActivitySummary.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import SwiftUI

struct ChatActivitySummaryView: View {
    var activity: Activity
    var user: AppUser
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(activity.activityDesc)
                .font(.headline)
            Text("Hosted by \(user.prename) \(user.surname)")
                .font(.subheadline)
            Text("Location: \(activity.locationDesc)")
                .font(.subheadline)
            Text("Time: \(activity.time.formatted(.dateTime.hour().minute()))")
                .font(.subheadline)
            Text("Date: \(activity.time.formatted(.dateTime.year().month().day()))")
                .font(.subheadline)
            Text("Registered people: \(activity.registeredPeopleCount)")
                .font(.subheadline)
        }
    }
}

struct ChatActivitySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ChatActivitySummaryView(
            activity: MockActivities.activities[0],
            user: MockUsers.users[0]
        )
    }
}
