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
                HStack {
                    Text(activity.activityDesc)
                        .font(.custom("Nunito-Regular", size: 20))
                        
                    Spacer()
                    Image(systemName: "sparkles.rectangle.stack.fill").font(.system(size: 24))
                }
                Spacer().frame(height: 20)
                HStack(spacing: 40) {
                    VStack {
                        Image(systemName: "person.circle").frame(width: 60, height: 60)
                        Text("Hosted by ")
                            .font(.custom("Nunito-Regular", size: 14))
                        Text("\(user.prename) \(user.surname)")
                    }.frame(minWidth: 140)
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "clock").frame(width: 40)
                            Text(" \(activity.time.formatted(.dateTime.hour().minute()))")
                                .font(.custom("Nunito-Regular", size: 14))
                        }
                        HStack {
                            Image(systemName: "calendar").frame(width: 40)
                            Text(" \(activity.time.formatted(.dateTime.year().month().day()))")
                                .font(.custom("Nunito-Regular", size: 14))
                        }
                        HStack {
                            Image(systemName: "person.3.fill").frame(width: 40)
                            Text(" \(activity.registeredPeopleCount) friends")
                                .font(.custom("Nunito-Regular", size: 14))
                        }
                    }
                }
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
