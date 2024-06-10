//
//  AppDelegate.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

//
//  AppDelegate.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import FirebaseAuth
import FirebaseAppCheck
import AppCheckCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let globalData = GlobalData()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        globalData.initializeAuth()  // Now safe to call after Firebase is configured
        #if DEBUG
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        #endif
        return true
    }
    
    private func updateGlobalData(user: User?) {
        if let user = user {
            globalData.isLoggedIn = true
            globalData.userName = user.displayName
            globalData.userEmail = user.email
            globalData.userProfileImageURL = user.photoURL
            print("FirebaseAuthListener: User signed in: \(user.email ?? "No Email")")
        } else {
            globalData.isLoggedIn = false
            print("FirebaseAuthListener: No user is signed in")
        }
        print("FirebaseAuthListener: isLoggedIn = \(globalData.isLoggedIn)")
    }
}
