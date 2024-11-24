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
            id: 0,
            prename: "Björn",
            surname: "Smith",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            age: 28,
            interests: ["Hiking", "Reading", "Cooking"],
            experiences: ["Software Engineer", "Project Manager"],
            previousActivities: ["Hiking in Yosemite", "Cooking class"],
            avatarURL: AssetExtractor.createLocalUrl(forImageNamed: "niko")
        ),
        AppUser(
            id: 1,
            prename: "John",
            surname: "Johnson",
            homeLocationLatLong: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
            age: 32,
            interests: ["Movies", "Gaming", "Traveling"],
            experiences: ["Graphic Designer", "Freelancer"],
            previousActivities: ["Movie marathon", "Trip to Japan"],
            avatarURL: AssetExtractor.createLocalUrl(forImageNamed: "vincent"),
            isCurrentUser: true
        ),
    ]
}
