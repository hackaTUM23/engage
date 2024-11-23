//
//  MockActivities.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import Foundation
import CoreLocation

struct MockActivities {
    static let activities: [Activity] = [
        Activity(
            id: 1,
            activityDesc: "Go to the movies",
            time: Date(),
            locationDesc: "Downtown Cinema",
            locationLatLong: CLLocationCoordinate2D(latitude: 48.137154, longitude: 11.576124),
            registeredPeopleCount: 5
        ),
        Activity(
            id: 2,
            activityDesc: "Hiking",
            time: Date(),
            locationDesc: "Mountain Trail",
            locationLatLong: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
            registeredPeopleCount: 8
        ),
        Activity(
            id: 3,
            activityDesc: "Dinner at a restaurant",
            time: Date(),
            locationDesc: "Italian Bistro",
            locationLatLong: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            registeredPeopleCount: 4
        ),
        Activity(
            id: 4,
            activityDesc: "Board game night",
            time: Date(),
            locationDesc: "Friend's House",
            locationLatLong: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),
            registeredPeopleCount: 6
        )
    ]
}
