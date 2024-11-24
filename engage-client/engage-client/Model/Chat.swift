//
//  Model.swift
//  engage-client
//
//  Created by Nikolai Madlener on 24.11.24.
//

import Foundation

struct ChatMessage: Codable {
    let matchmakerId: Int
    let userId: Int
    let timestamp: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case matchmakerId = "matchmaker_id"
        case userId = "user_id"
        case timestamp
        case message
    }
}

// Helper class to handle chat operations
class Chat {
    static func parseMessages(from json: String) -> [ChatMessage]? {
        guard let data = json.data(using: .utf8) else { return nil }
        
        do {
            let messages = try JSONDecoder().decode([ChatMessage].self, from: data)
            return messages
        } catch {
            print("Error parsing chat messages: \(error)")
            return nil
        }
    }
    
    static func encodeMessage(_ message: ChatMessage) -> Data? {
        do {
            let encoder = JSONEncoder()
            // Make the JSON output pretty-printed
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(message)
        } catch {
            print("Error encoding chat messages: \(error)")
            return nil
        }
    }
}

