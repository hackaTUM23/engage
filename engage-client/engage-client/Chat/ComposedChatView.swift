//
//  ComposedChatView.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//
import SwiftUI
import ExyteChat

struct ComposedChatView : View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if let activity = appState.nextActivity {
            VStack {
                ChatActivitySummaryView(activity: activity, user: appState.user).padding()
                CustomChatView()
            }
        }
        
    }
}


struct ComposedChatView_Previews: PreviewProvider {
    static var previews: some View {
        ComposedChatView().environmentObject(mockStateNextActivity)
    }
}
