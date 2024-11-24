//
//  engage_clientApp.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI

@main
struct engage_clientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font, Font.custom("Nunito-Regular", size: 14))
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
