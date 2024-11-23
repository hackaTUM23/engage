//
//  MockUsers.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import Foundation
import CoreLocation

struct MockUsers {
    static let users: [AppUser] = [
        AppUser(
            id: 1,
            prename: "Alice",
            surname: "Smith",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            age: 28,
            interests: ["Hiking", "Reading", "Cooking"],
            experiences: ["Software Engineer", "Project Manager"],
            previousActivities: ["Hiking in Yosemite", "Cooking class"]
        ),
        AppUser(
            id: 2,
            prename: "Bob",
            surname: "Johnson",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
            age: 32,
            interests: ["Movies", "Gaming", "Traveling"],
            experiences: ["Graphic Designer", "Freelancer"],
            previousActivities: ["Movie marathon", "Trip to Japan"]
        ),
        AppUser(
            id: 3,
            prename: "Charlie",
            surname: "Brown",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            age: 25,
            interests: ["Music", "Photography", "Cycling"],
            experiences: ["Musician", "Photographer"],
            previousActivities: ["Concert tour", "Photo exhibition"]
        ),
        AppUser(
            id: 4,
            prename: "David",
            surname: "Williams",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),
            age: 30,
            interests: ["Football", "Cooking", "Traveling"],
            experiences: ["Chef", "Travel Blogger"],
            previousActivities: ["Football match", "Cooking competition"]
        ),
        AppUser(
            id: 5,
            prename: "Eve",
            surname: "Davis",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
            age: 27,
            interests: ["Art", "Yoga", "Reading"],
            experiences: ["Artist", "Yoga Instructor"],
            previousActivities: ["Art exhibition", "Yoga retreat"]
        )
    ]
}
