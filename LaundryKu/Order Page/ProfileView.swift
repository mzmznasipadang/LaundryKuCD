//
//  ProfileView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 05/06/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var globalData: GlobalData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            if let url = globalData.userProfileImageURL {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Text("Failed to load image")
                            .foregroundColor(.red)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
            }

            Text(globalData.userName ?? "No Name")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(globalData.userEmail ?? "No Email")
                .font(.subheadline)
                .foregroundColor(.gray)

            Button(action: {
                signOut()
            }) {
                Text("Sign Out")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            globalData.isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(GlobalData())
    }
}
