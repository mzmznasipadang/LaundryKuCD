//
//  GlobalData.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import Foundation
import Combine
import FirebaseAuth
import SwiftUI

class GlobalData: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isOnboardingCompleted: Bool = UserDefaults.standard.bool(forKey: "isOnboardingCompleted") {
        didSet {
            UserDefaults.standard.set(isOnboardingCompleted, forKey: "isOnboardingCompleted")
        }
    }
    @Published var userName: String?
    @Published var userEmail: String?
    @Published var userProfileImageURL: URL?
    @Published var isLocationAccessGranted: Bool = UserDefaults.standard.bool(forKey: "isLocationAccessGranted") {
            didSet {
                UserDefaults.standard.set(isLocationAccessGranted, forKey: "isLocationAccessGranted")
            }
        }

    func completeOnboarding() {
        isOnboardingCompleted = true
    }

    func initializeAuth() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            self?.updateUserInformation(user)
        }
    }

    func updateUserInformation(_ user: User?) {
        DispatchQueue.main.async {
            if let user = user {
                self.isLoggedIn = true
                self.userName = user.displayName
                self.userEmail = user.email
                self.userProfileImageURL = user.photoURL
            } else {
                self.isLoggedIn = false
                self.userName = nil
                self.userEmail = nil
                self.userProfileImageURL = nil
            }
        }
    }
    func setLocationAccess(granted: Bool) {
            // Handle the location access setting
            UserDefaults.standard.set(granted, forKey: "isLocationAccessGranted")
            isLocationAccessGranted = granted
        }
}
