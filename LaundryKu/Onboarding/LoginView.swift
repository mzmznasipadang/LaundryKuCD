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

    var body: some View {
        NavigationStack {
            ZStack {
                Image("ob2") // Background image for the login screen
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    GeometryReader { geometry in
                        VStack(spacing: 20) {
                            Text("Login")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                                .padding(.bottom, 20)

                            TextField("Enter your email", text: $email)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)

                            SecureField("Enter your password", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)

                            Button(action: loginUser) {
                                Text("Log In")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                            }
                            .padding(.vertical, 20)

                            NavigationLink(destination: SignUpView().environmentObject(globalData)) {
                                Text("Don't have an account yet?")
                                    .foregroundColor(.accentColor)
                                Text("Register Here")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor"))
                            }

                            Text("or")
                                .foregroundColor(.gray)
                                .padding()

                            SocialLoginButtons()
                        }
                        .padding()
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .frame(width: geometry.size.width * 0.35)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * 0.3))
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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

    @ViewBuilder
    func SocialLoginButtons() -> some View {
        HStack(spacing: 20) {
            SignInWithAppleButton(.signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Authorization successful: \(authResults)")
                    case .failure(let error):
                        print("Authorization failed: \(error.localizedDescription)")
                    }
                }
            )
            .frame(width: 150, height: 50)
            .cornerRadius(15)
            .shadow(radius: 3)

            Button(action: handleGoogleSignIn) {
                Image("googlelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(13)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            }
        }
        .padding(.bottom, 50.0)
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
