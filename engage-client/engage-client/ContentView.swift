//
//  ContentView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import DeviceActivity
import FamilyControls

struct ContentView: View {
    @State private var showAcceptEventModal = false
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone])
    )

    var body: some View {
        TabView {
            ActivityOverview()
                .tabItem {
                    Label("Activities", systemImage: "list.dash")
                }
            VStack{
                Text("Test")
                DeviceActivityReport(context, filter: filter)
            } // todo: replace with ChatView
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
            AcceptEventModalView()
        }
    }
}

struct AcceptEventModalView: View {
    var body: some View {
        Text("meeting invitation!")
            .font(.title)
            .padding()
    }
}



#Preview {
    ContentView()
}
