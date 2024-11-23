//
//  AcceptEventModalView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import CoreLocation

struct AcceptEventModalView: View {
    @Environment(\.dismiss) var dismiss
    
    var activity: Activity
    
    var body: some View {
        VStack {
            Text("Get going!").font(.title).padding()
            Image("spriessen")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
            ChatActivitySummaryView(activity: MockActivities.activities[0], user: MockUsers.users[0])
            Spacer()
            HStack {
                Button("Decline", role: .cancel) {
                    dismiss()
                }
                .buttonStyle(.bordered)
                .padding()
                .frame(maxWidth: .infinity)
                Button("Accept") {
                    accept()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    func accept() {
        dismiss()
    }
}

#Preview {
    AcceptEventModalView(activity: MockActivities.activities[0])
}
