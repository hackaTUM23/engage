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
    @StateObject var appState = mockStateNextActivity
    //AppState(
    //    activities: [], user: MockUsers.users[0], preferences: []
    //)

    var body: some View {
        Group {
            if(appState.hasNextActivity) {
                ComposedChatView()
                    .padding()
                    .tabItem {
                        Label("Next Activity", systemImage: "bubble.left.and.text.bubble.right")
                    }
            } else {
                ActivityOverview()
                    .tabItem {
                        Label("Home", systemImage: "house")
                }
            }
  
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("ShowAcceptEventModal"), object: nil, queue: .main) { _ in
                // TODO fetch best activity
                self.showAcceptEventModal = true
            }
        }
        .sheet(isPresented: $showAcceptEventModal) {
            AcceptEventModalView(activity: activity)
        }
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
}
