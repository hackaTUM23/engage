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
            Text("Tom wants you to join him to \(activity.activityDesc).").font(.callout)
                .padding()
            Spacer()
            // todo: Sanshas component
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
    let activity = Activity(id: 1, activityDesc: "go for a walk", time: Date(), locationDesc: "test location desc", locationLatLong: CLLocationCoordinate2D(), registeredPeopleCount: 1)
                            
    AcceptEventModalView(activity: activity)
}
