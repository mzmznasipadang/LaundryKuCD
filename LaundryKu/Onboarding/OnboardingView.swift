//
//  OnboardingView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("testbg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                // Overlay with a white background
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Looking for good cleaner?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.accent)
                            .padding(.top, 25)
                        
                        Text("From 500+ laundries in South Tangerang that proudly offers good cleaning for your needs.")
                            .foregroundStyle(.accent)
                            .frame(width: 327, alignment: .leading) // Adjust the width if necessary
                        
                        NavigationLink(destination: OnboardingView1().environmentObject(globalData)) {
                            Text("Next")
                                .frame(width: 305, height: 44)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top, 20) // Adds space above the button
                    }
                    .padding(.horizontal, 32) // Horizontal padding for the text container
                    .padding(.bottom, 40) // Adds space at the bottom
                    .background(Color.white) // Background color of the text container
                    .cornerRadius(20)
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(GlobalData())
    }
}
