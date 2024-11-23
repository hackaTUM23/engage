//
//  ContentView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var showAcceptEventModal = false
    @State var activity: Activity = MockActivities.activities[0]

    var body: some View {
        TabView {
            ActivityOverview()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ComposedChatView(activity: MockActivities.activities[0], user: MockUsers.users[0], messages: mockMessages)
                .padding()
                .tabItem {
                    Label("Next Activity", systemImage: "bubble.left.and.text.bubble.right")
                }
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("ShowAcceptEventModal"), object: nil, queue: .main) { _ in
                self.showAcceptEventModal = true
            }
        }
        .sheet(isPresented: $showAcceptEventModal) {
            AcceptEventModalView(activity: activity)
        }
    }
}

#Preview {
    ContentView()
}
