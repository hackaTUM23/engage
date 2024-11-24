//
//  ActivityDetailView.swift
//  engage-client
//
//  Created by Nikolai Madlener on 24.11.24.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    var activity: Activity
    @State var acceptLoading = false
    
    var body: some View {
        VStack {
            SheetPill()
            ChatActivitySummaryView(activity: MockActivities.activities[0], user: MockUsers.users[0]).padding()
            Spacer()
            Button {
                Task {
                    await accept()
                }
            } label: {
                if acceptLoading {
                    ProgressView()
                } else {
                    Text("Let's Go!")
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .frame(maxWidth: .infinity)
            .disabled(acceptLoading)
        }
    }
    
    func accept() async {
        
    }
}

#Preview {
    ActivityDetailView(activity: MockActivities.activities[0])
}
