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
    
    var region: MKCoordinateRegion {
           MKCoordinateRegion(
               center: activity.locationLatLong,
               span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
           )
       }
    
    // Create an array of annotations for the map
     var annotationItems: [IdentifiableCoordinate] {
         [IdentifiableCoordinate(coordinate: activity.locationLatLong, title: activity.locationDesc ?? "")]
     }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ActivityListView(activity: activity, user: user)
                Spacer().frame(height: 14)
                Map(coordinateRegion: .constant(region), annotationItems: annotationItems) { item in
                                    MapMarker(coordinate: item.coordinate)
                                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(maxHeight: 140)
            }.padding()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// Struct to make coordinates identifiable (since Map needs identifiable items)
struct IdentifiableCoordinate: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    var title: String
}

struct ChatActivitySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ChatActivitySummaryView(
            activity: MockActivities.activities[0],
            user: MockUsers.users[0]
        )
    }
}
