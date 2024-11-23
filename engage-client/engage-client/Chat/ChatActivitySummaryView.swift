//
//  ChatActivitySummary.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import SwiftUI
import MapKit

struct ChatActivitySummaryView: View {
    var activity: Activity
    var user: AppUser
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ActivityListView(activity: activity, user: user)
                Spacer().frame(height: 20)
                Map {
                    Marker(activity.locationDesc, coordinate: activity.locationLatLong)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(maxHeight: 200)
            }.padding()
        }.background(Color(UIColor.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
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
