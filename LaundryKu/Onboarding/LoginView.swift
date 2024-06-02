//
//  LoginView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI
import AuthenticationServices
import Firebase
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Login Title
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                // Email Field
                VStack(alignment: .leading) {
                    Text("Enter Your Email")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding(.leading, 20.0)
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                // Password Field
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
                    loginUser()
                }) {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                // Navigate to SignUpView
                NavigationLink(destination: SignUpView().environmentObject(globalData)) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
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
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 50)))
                    
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
    }
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            globalData.isLoggedIn = true
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(GlobalData())
    }
}
