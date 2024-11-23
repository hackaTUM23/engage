//
//  engage_clientApp.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import FamilyControls
import DeviceActivity


@main
struct engage_clientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let center = AuthorizationCenter.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
            .onAppear {
                Task {
                    do {
                        try await center.requestAuthorization(for: .individual)
                    } catch {
                        print("Failed to enroll with error: \(error)")
                    }
                }
            }
        }
    }
}
