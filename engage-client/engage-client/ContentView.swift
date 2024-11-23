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
    @State var activity: Activity = Activity(id: 1, activityDesc: "Go for a walk", time: Date(), locationDesc: "test location desc", locationLatLong: CLLocationCoordinate2D(), registeredPeopleCount: 1)

    var body: some View {
        TabView {
            ActivityOverview()
                .tabItem {
                    Label("Activities", systemImage: "list.dash")
                }
            VStack{} // todo: replace with ChatView
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
