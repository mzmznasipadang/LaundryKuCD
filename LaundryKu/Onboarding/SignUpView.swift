//
//  SignUpView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import Foundation
import SwiftUI
import AuthenticationServices
import Firebase
import FirebaseAuth
import GoogleSignIn

struct SignUpView: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var name: String = " "
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // SignUp Title
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Nama?
            VStack(alignment: .leading) {
                Text("Enter Your Name")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 20.0)
                TextField("Fullname", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            // Email
            VStack(alignment: .leading) {
                Text("Enter Your Email")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 20.0)
                SecureField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            // Password
            VStack(alignment: .leading) {
                Text("Enter Your Password")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 20.0)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            // Login Button
            Button(action: {
                // Handle login
            }) {
                Text("Sign Up")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            // Or Text
            Text("or")
                .foregroundColor(.gray)
                .padding(.vertical)
            
            // Social Login Buttons
            HStack(spacing:20) {
                // Apple Sign In Button
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            print("Authorization successful: \(authResults)")
                            // Handle successful authorization
                        case .failure(let error):
                            print("Authorization failed: \(error.localizedDescription)")
                            // Handle error
                        }
                    }
                )
                .frame(width: 150, height: 50)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 50) ))
                
                // Google Login Button
                Button(action: {
                    handleGoogleSignIn()
                }) {
                    Image("googlelogo") // Use the appropriate image for Google
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
    func handleGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        _ = GIDConfiguration(clientID: clientID)
        
        guard let presentingViewController = getRootViewController() else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [self] result, error in
            authenticateUser(for: result?.user, with: error)
        }
    }
    
    func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print("Error signing in with Google: \(error.localizedDescription)")
            return
        }
        
        guard let user = user else { return }
        let idToken = user.idToken?.tokenString
        let accessToken = user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("Firebase sign in with Google failed: \(error.localizedDescription)")
                return
            }
            
            print("User signed in with Google")
            globalData.isLoggedIn = true
        }
    }
    
    func getRootViewController() -> UIViewController? {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        guard let rootViewController = screen.windows.first?.rootViewController else {
            return nil
        }
        return rootViewController
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(GlobalData())
    }
}
