//
//  OnboardingView1.swift
//  LaundryKu
//
//  Created by Victor Chandra on 03/06/24.
//

import Foundation
import SwiftUI

struct OnboardingView1: View {
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                Image("ob1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                // Overlay with a white background
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Worry free, just click!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.accent)
                            .padding(.top, 25)
                        
                        Text("24/7 support is available just for you! Enjoy hassle free cleaning your laundry!")
                            .foregroundStyle(.accent)
                            .frame(width: 327, alignment: .leading)
                        
                        NavigationLink(destination: OnboardingView2().environmentObject(globalData)) {
                            Text("Next")
                                .frame(width: 305, height: 44)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 100)
                    .background(Color.white)
                    .cornerRadius(20)
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)  // Hides the back button on this view
    }
}


struct OnboardingView1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView1().environmentObject(GlobalData())
    }
}
