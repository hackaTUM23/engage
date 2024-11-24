//
//  SheetPill.swift
//  engage-client
//
//  Created by Nikolai Madlener on 24.11.24.
//

import SwiftUI

struct SheetPill: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
            .frame(width: 80, height: 4)
            .padding(.top, 8)
    }
}

#Preview {
    SheetPill()
}
