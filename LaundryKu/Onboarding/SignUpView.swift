//
//  SignUpView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var acceptedTerms: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("ob2") // Background image for the signup screen
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    GeometryReader { geometry in
                        VStack(spacing: 20) {
                            Text("Sign Up")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                                .padding(.bottom, 20)

                            InputField(title: "First name", value: $name)
                            InputField(title: "Email", value: $email)
                            InputField(title: "Password", value: $password, isSecure: true)
                            InputField(title: "Confirm Password", value: $confirmPassword, isSecure: true)

                            HStack {
                                Toggle(isOn: $acceptedTerms) {
                                    Text("I accept the ")
                                    + Text("Terms")
                                        .underline()
                                        .foregroundColor(.blue)
                                    + Text(" and I have read the ")
                                    + Text("Privacy Policy & cookies")
                                        .underline()
                                        .foregroundColor(.blue)
                                }
                                .padding(.horizontal)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                            }
                            .padding(.horizontal, 20)

                            Button(action: registerUser) {
                                Text("Join us")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                            }
                            .padding(.vertical, 20)
                        }
                        .padding()
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .frame(width: geometry.size.width * 0.35)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * 0.39))
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.8) // Adjust height as necessary
                }
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func registerUser() {
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match"
            showAlert = true
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
                return
            }

            guard let uid = authResult?.user.uid else { return }

            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "email": email,
                "uid": uid
            ]) { error in
                if let error = error {
                    alertMessage = error.localizedDescription
                    showAlert = true
                    return
                }
                globalData.isLoggedIn = true
            }
        }
    }
}

struct InputField: View {
    var title: String
    @Binding var value: String
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.leading, 20.0)
            if isSecure {
                SecureField("Enter here", text: $value)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal)
            } else {
                TextField("Enter here", text: $value)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(GlobalData())
    }
}
