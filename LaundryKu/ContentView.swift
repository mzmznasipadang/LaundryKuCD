//
//  ContentView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboardingComplete = false
    @State private var isLoggedIn = false

    var body: some View {
        if !isOnboardingComplete {
            OnboardingView()
                .onAppear {
                    // Simulate onboarding completion after delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isOnboardingComplete = true
                    }
                }
        } else if !isLoggedIn {
            LoginView()
                .onAppear {
                    // Simulate login after delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoggedIn = true
                    }
                }
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
