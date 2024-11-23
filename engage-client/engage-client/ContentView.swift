//
//  ContentView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

struct ContentView: View {
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
        
    }
}

#Preview {
    ContentView()
}
