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
                    Label("Activities", systemImage: "list.dash")
                }
            ComposedChatView(activity: MockActivities.activities[0], user: MockUsers.users[0], messages: mockMessages)
                .padding()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
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
