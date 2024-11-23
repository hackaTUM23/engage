//
//  ContentView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAcceptEventModal = false

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
