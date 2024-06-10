//
//  OnboardingView2.swift
//  LaundryKu
//
//  Created by Victor Chandra on 03/06/24.
//

import SwiftUI
import UserNotifications
import FirebaseAuth

struct OnboardingView2: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var showAlert = false
    @State private var navigateToNextView = false
    
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                ZStack {
                    Image("ob2") // Ensure this is the correct image asset for the background.
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    
                    VStack {
                        Spacer() // Pushes the container to the bottom
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Don’t miss our updates!")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.accent)
                                .padding(.top, 25)
                            
                            Text("We won’t spam you, guaranteed. But we will provide you the update for your laundry cleaning progress.")
                                .foregroundStyle(.accent)
                                .frame(width: 327, alignment: .leading)
                                .padding(.bottom, 25)
                            
                            Button(action: {
                                showAlert = true
                            }) {
                                Text("Continue")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 305, height: 44)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 40)
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("LaundryKu would like to send you notifications"),
                                    message: Text("Notifications may include alerts, sounds, and icon badges. These can be configured in Settings."),
                                    primaryButton: .default(Text("Allow"), action: {
                                        requestNotificationPermission()
                                    }),
                                    secondaryButton: .cancel(Text("Don't Allow"), action: {
                                        markOnboardingCompleted()
                                    })
                                )
                            }
                        }
                        .padding(.horizontal, 30) // Horizontal padding for the text container
                        .padding(.bottom, 100) // Adds space at the bottom
                        .background(Color.white) // Background color of the text container
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.width - 48) // Adjust width to have some side margins
                    }
                    .onChange(of: globalData.isOnboardingCompleted) {
                        navigateToNextView = true
                    }
                    .navigationDestination(isPresented: $navigateToNextView) {
                        if globalData.isLoggedIn {
                            HomeView().environmentObject(globalData)
                        } else {
                            LoginView().environmentObject(globalData)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
                markOnboardingCompleted()
            }
        }
    }
    
    func markOnboardingCompleted() {
        print("Marking onboarding as completed")
        globalData.isOnboardingCompleted = true
        UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
        print("isOnboardingCompleted set to \(globalData.isOnboardingCompleted)")
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView2().environmentObject(GlobalData())
    }
}
