//
//  ActivityOverview.swift
//  engage-client
//
//  Created by Nikolai Madlener on 23.11.24.
//

import SwiftUI
import CoreLocation

struct ActivityOverview: View {
    @EnvironmentObject var appState: AppState
    
    let welcomeText = "Welcome back! Here are some activities we recommend for you."
    @State private var loading = true
    @State private var showDetailModal = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    UserIconView()
                        .frame(maxWidth: 60, maxHeight: 60)
                    Text("Hi \(appState.user.prename)!")
                        .font(.custom("Nunito-Bold", size: 32)).padding(.leading, 8)
                        .onTapGesture {
                            if (appState.user.id == 0) {
                                print("switch to chat for user \(appState.user.id)")
                                appState.chatContext = ChatContext(messages: [], otherUser: MockUsers.users[1].chatUser!, matchMakerId: 1)
                                appState.nextActivity = mainMockActivity
                            }
                        }
                    Spacer()
                }.padding(.leading, 20)
                Group {
                    Text(welcomeText)
                        .font(.custom("Nunito-Regular", size: 14)).padding(.horizontal, 14).multilineTextAlignment(.center)
                    PreferenceSelectionView()
                }.padding()
                if !loading {
                    if appState.activities.isEmpty {
                        Spacer()
                        Text("No Activities Found.")
                        Spacer()
                    } else {
                        ForEach(appState.activities) { activity in
                            ActivityListView(activity: activity, user: appState.user).onTapGesture {
                                showDetailModal.toggle()
                            }.padding()
                            .sheet(isPresented: $showDetailModal) {
                                ActivityDetailView(activity: activity)
                            }
                            Divider()
                        }
                    }
                } else {
                    ProgressView()
                }
                Spacer()
            }
        }
        .task {
//            await fetchActivities()
            appState.activities = MockActivities.activities
            loading = false
        }
    }
    
    
}

#Preview {
    ActivityOverview().environmentObject(mockStateNoNextActivity)
}
