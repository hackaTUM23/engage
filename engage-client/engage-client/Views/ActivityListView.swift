//
//  ActivityListView.swift
//  engage-client
//
//  Created by Sandesh Sharma on 24.11.24.
//

import SwiftUI
import MapKit

struct ActivityListView: View {
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
                        Image("marcel")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(maxWidth: 60, maxHeight: 60)
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
            }.padding()
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView(
            activity: MockActivities.activities[0],
            user: MockUsers.users[0]
        )
    }
}
