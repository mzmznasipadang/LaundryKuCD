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
                        .frame(width: 200, height: 200)
                    Text("LaundryKu")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("AccentColor"))
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
