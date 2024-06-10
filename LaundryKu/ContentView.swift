//
//  ContentView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalData: GlobalData

    var body: some View {
        if !globalData.isOnboardingCompleted {
            OnboardingView()
                .onAppear {
                    // You might want to remove the delay here and trigger completion via a button or an action within OnboardingView
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        globalData.completeOnboarding()
                    }
                }
        } else if !globalData.isLoggedIn {
            LoginView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalData())
    }
}
