//
//  Activity.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import Foundation
import CoreLocation

class Activity: Codable, Identifiable {
    var id: Int?
    var activityDesc: String?
    var time: Date
    var locationDesc: String?
    var locationLatLong: CLLocationCoordinate2D
    var registeredPeopleCount: Int
    
    init(id: Int?, activityDesc: String?, time: Date, locationDesc: String?, locationLatLong: CLLocationCoordinate2D, registeredPeopleCount: Int) {
        self.id = id
        self.activityDesc = activityDesc
        self.time = time
        self.locationDesc = locationDesc
        self.locationLatLong = locationLatLong
        self.registeredPeopleCount = registeredPeopleCount
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case activityDesc = "activity_desc"
        case time
        case locationDesc = "location_desc"
        case locationLatLong = "location_lat_long"
        case registeredPeopleCount = "registered_people_count"
    }
    
    enum LocationLatLongCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        activityDesc = try container.decodeIfPresent(String.self, forKey: .activityDesc)
        time = try container.decode(Date.self, forKey: .time)
        locationDesc = try container.decode(String?.self, forKey: .locationDesc)
        
        // Decode locationLatLong as an array of two doubles
        let coordinates = try container.decode([Double].self, forKey: .locationLatLong)
        guard coordinates.count == 2 else {
            throw DecodingError.dataCorruptedError(
                forKey: .locationLatLong,
                in: container,
                debugDescription: "locationLatLong array must contain exactly 2 elements"
            )
        }
        print(coordinates)
        locationLatLong = CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
        
        registeredPeopleCount = try container.decode(Int.self, forKey: .registeredPeopleCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(activityDesc, forKey: .activityDesc)
        try container.encode(time, forKey: .time)
        try container.encode(locationDesc, forKey: .locationDesc)
        
        var locationContainer = container.nestedContainer(keyedBy: LocationLatLongCodingKeys.self, forKey: .locationLatLong)
        try locationContainer.encode(locationLatLong.latitude, forKey: .latitude)
        try locationContainer.encode(locationLatLong.longitude, forKey: .longitude)
        
        try container.encode(registeredPeopleCount, forKey: .registeredPeopleCount)
    }
}
