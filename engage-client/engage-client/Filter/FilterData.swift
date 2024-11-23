//
//  FilterData.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import Foundation

struct FilterData: Identifiable {
    var id = UUID()
    var title: String
    var isSelected: Bool = false
}
