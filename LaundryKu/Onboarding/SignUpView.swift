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
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Sign Up Title
            Text("Sign Up")
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

            // Confirm Password Field
            VStack(alignment: .leading) {
                Text("Confirm Your Password")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 20.0)
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            // Sign Up Button
            Button(action: {
                registerUser()
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

            // Back to Login Button
            Button(action: {
                globalData.isOnboardingCompleted = true
            }) {
                Text("Already have an account? Login")
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(GlobalData())
    }
}
