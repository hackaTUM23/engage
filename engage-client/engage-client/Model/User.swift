import Foundation
import CoreLocation

class AppUser: Codable {
    var id: Int
    var prename: String
    var surname: String
    var homeLocationLatLong: CLLocationCoordinate2D
    var age: Int
    var interests: [String]
    var experiences: [String]
    var previousActivities: [String]
    
    init(id: Int, prename: String, surname: String, homeLocationLatLong: CLLocationCoordinate2D, age: Int, interests: [String], experiences: [String], previousActivities: [String]) {
        self.id = id
        self.prename = prename
        self.surname = surname
        self.homeLocationLatLong = homeLocationLatLong
        self.age = age
        self.interests = interests
        self.experiences = experiences
        self.previousActivities = previousActivities
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case prename
        case surname
        case homeLocationLatLong = "home_location_lat_long"
        case age
        case interests
        case experiences
        case previousActivities = "previous_activities"
    }
    
    enum HomeLocationLatLongCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        prename = try container.decode(String.self, forKey: .prename)
        surname = try container.decode(String.self, forKey: .surname)
        age = try container.decode(Int.self, forKey: .age)
        interests = try container.decode([String].self, forKey: .interests)
        experiences = try container.decode([String].self, forKey: .experiences)
        previousActivities = try container.decode([String].self, forKey: .previousActivities)
        
        let locationContainer = try container.nestedContainer(keyedBy: HomeLocationLatLongCodingKeys.self, forKey: .homeLocationLatLong)
        let latitude = try locationContainer.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try locationContainer.decode(CLLocationDegrees.self, forKey: .longitude)
        homeLocationLatLong = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(prename, forKey: .prename)
        try container.encode(surname, forKey: .surname)
        try container.encode(age, forKey: .age)
        try container.encode(interests, forKey: .interests)
        try container.encode(experiences, forKey: .experiences)
        try container.encode(previousActivities, forKey: .previousActivities)
        
        var locationContainer = container.nestedContainer(keyedBy: HomeLocationLatLongCodingKeys.self, forKey: .homeLocationLatLong)
        try locationContainer.encode(homeLocationLatLong.latitude, forKey: .latitude)
        try locationContainer.encode(homeLocationLatLong.longitude, forKey: .longitude)
    }
}//
//  User.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

