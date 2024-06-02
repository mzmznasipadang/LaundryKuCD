//
//  OnboardingView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            // Page Indicator
            HStack {
                ForEach(0..<5) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(index == 0 ? Color.white : Color.white.opacity(0.5))
                        .frame(width: 20, height: 4)
                }
            }
            .padding(.top, 20)
            
            // Onboarding Image
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 375, height: 573)
            .background(
            Image("onboarding_image")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 375, height: 573)
            .clipped()
            )
            
            // Text Content
            VStack(alignment: .leading, spacing: 10) {
                Text("Shop better, look good.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("10,000 brands up to 70% off retail price, all great for the planet")
                    .font(.body)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
            
            // Next Button
            Button(action: {
                // Handle next button action
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Color.gray.opacity(0.2))
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
