//
//  OnboardingView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import Foundation
import SwiftUI
import UserNotifications

struct OnboardingSlide: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var currentPage = 0
    @State private var showAlert = false
    
    let slides = [
        OnboardingSlide(imageName: "onboarding_image1", title: "Shop better, look good.", description: "10,000 brands up to 70% off retail price, all great for the planet"),
        OnboardingSlide(imageName: "onboarding_image2", title: "Don’t worry, buy happy.", description: "Because millions of shoppers trust our quality control service."),
        OnboardingSlide(imageName: "onboarding_image3", title: "Sell on, join us.", description: "With 15M members, you’ll be sure you find someone who loves your items."),
        OnboardingSlide(imageName: "onboarding_image4", title: "Get updates on items you buy and sell.", description: "Get notifications about activity on your listings and price drops on items you love.")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                TabView(selection: $currentPage) {
                    ForEach(slides.indices, id: \.self) { index in
                        ZStack(alignment: .bottom) {
                            // Onboarding Image
                            Image(slides[index].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .ignoresSafeArea()
                            
                            // Page Dots
                            HStack {
                                ForEach(slides.indices, id: \.self) { dotIndex in
                                    Circle()
                                        .fill(dotIndex == currentPage ? Color.white : Color.white.opacity(0.5))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.bottom, 90)
                            
                            // Text Content
                            VStack(alignment: .leading, spacing: 10) {
                                Text(slides[index].title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text(slides[index].description)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.bottom, 40)
                            
                            // Next/Continue Button
                            Button(action: {
                                if currentPage < slides.count - 1 {
                                    withAnimation {
                                        currentPage += 1
                                    }
                                } else {
                                    // Show alert to request notification permission
                                    showAlert = true
                                }
                            }) {
                                Text(currentPage < slides.count - 1 ? "Next" : "Continue")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .padding(.bottom, 20)
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("LaundryKu would like to send you notifications"),
                                    message: Text("Notifications may include alerts, sounds, and icon badges. These can be configured in Settings."),
                                    primaryButton: .default(Text("Allow"), action: {
                                        requestNotificationPermission()
                                    }),
                                    secondaryButton: .cancel(Text("Don't Allow"), action: {
                                        globalData.isLoggedIn = true // Navigate to the next view if needed
                                    })
                                )
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("Permission granted")
                } else {
                    print("Permission denied")
                }
                globalData.isLoggedIn = true // Navigate to the next view if needed
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(GlobalData())
    }
}
