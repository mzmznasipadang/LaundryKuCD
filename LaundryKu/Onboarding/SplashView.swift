//
//  SplashView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.1
    @State private var opacity = 0.5
    @EnvironmentObject var globalData: GlobalData

    var body: some View {
        if isActive {
            if globalData.isLoggedIn {
                HomeView().environmentObject(globalData)
            } else {
                OnboardingView().environmentObject(globalData)
            }
        } else {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                self.size = 0.6
                                self.opacity = 1.0
                            }
                        }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().environmentObject(GlobalData())
    }
}
