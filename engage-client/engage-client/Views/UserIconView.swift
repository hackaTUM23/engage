//
//  UserIconView.swift
//  engage-client
//
//  Created by Sandesh Sharma on 23.11.24.
//

import SwiftUI
struct UserIconView: View {
    @EnvironmentObject var appState: AppState
    
    func toggleUser() {
        if appState.user.id == MockUsers.users.first!.id {
            appState.user = MockUsers.users.last!
        } else {
            appState.user = MockUsers.users.first!
        }
    }
    
    var body: some View {
        Image(appState.user.image_str)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .onTapGesture(perform: toggleUser)
    }
}

#Preview {
    UserIconView().environmentObject(mockStateNoNextActivity)
}
