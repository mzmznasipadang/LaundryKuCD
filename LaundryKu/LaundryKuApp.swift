//
//  LaundryKuApp.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct LaundryKuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var globalData = GlobalData()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if globalData.isLoggedIn {
                    HomeView().environmentObject(globalData)
                } else if globalData.isOnboardingCompleted {
                    LoginView().environmentObject(globalData)
                } else {
                    OnboardingView().environmentObject(globalData)
                }
            }
        }
    }
}
