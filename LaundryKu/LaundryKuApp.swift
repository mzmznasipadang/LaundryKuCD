//
//  LaundryKuApp.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI

@main
struct LaundryKuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var globalData = GlobalData()

    var body: some Scene {
        WindowGroup {
            if globalData.isLoggedIn {
                HomeView().environmentObject(globalData)
            } else {
                NavigationView {
                    SplashView()
                        .environmentObject(globalData)
                }
            }
        }
    }
}
