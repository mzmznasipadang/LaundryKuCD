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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var globalData = GlobalData()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(globalData)
                .onAppear {
                    setupGlobalData()
                }
        }
    }

    func setupGlobalData() {
        // Initialize any additional global data here if needed
        print("GlobalData initialized with isOnboardingCompleted = \(globalData.isOnboardingCompleted)")
    }
}
