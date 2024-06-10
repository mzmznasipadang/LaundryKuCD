//
//  SplashView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                if globalData.isLoggedIn {
                    HomeView().environmentObject(globalData)
                } else if globalData.isOnboardingCompleted {
                    LoginView().environmentObject(globalData)
                } else {
                    OnboardingView().environmentObject(globalData)
                }
            } else {
                ZStack {
                    Color.white.ignoresSafeArea()
                    VStack {
                        Image("logo").resizable().scaledToFit().frame(width: 200, height: 200)
                        Text("LaundryKu").font(.largeTitle).fontWeight(.semibold).foregroundColor(Color.blue)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Increased delay to ensure splash is visible longer
                self.isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().environmentObject(GlobalData())
    }
}
