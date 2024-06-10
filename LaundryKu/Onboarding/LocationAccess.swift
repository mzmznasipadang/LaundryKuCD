//
//  LocationView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 11/06/24.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    @EnvironmentObject var globalData: GlobalData
    @State private var showAlert = false
    @State private var navigateToNextView = false
    @State private var locationManagerDelegate = LocationManagerDelegate()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("loc") // Ensure you have the correct image asset
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

                    VStack {
                        Spacer()

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Allow location please?")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(.top, 25)

                            Text("Please allow location access, to tailor your service and showing all the nearby laundry store for you only. We won’t use it for other purposes, guaranteed! : (")
                                .foregroundColor(.blue)
                                .frame(width: 327, alignment: .leading)
                                .padding(.bottom, 25)

                            Button(action: {
                                requestLocationAccess()
                            }) {
                                Text("Use Current Location")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 305, height: 44)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)

                            Button(action: {
                                markLocationPermissionSkipped()
                            }) {
                                Text("Skip for now")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.bottom, 20)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 100)
                        .background(Color.white)
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.width - 48)
                    }
                    .onChange(of: globalData.isLocationAccessGranted) {
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Location Access"),
                    message: Text("Please allow location access to use this feature."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    func requestLocationAccess() {
        let locationManager = CLLocationManager()
        locationManager.delegate = locationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
    }

    func markLocationPermissionSkipped() {
        globalData.setLocationAccess(granted: false)
    }

    class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            guard let globalData = (UIApplication.shared.delegate as? AppDelegate)?.globalData else { return }
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                globalData.setLocationAccess(granted: true)
            case .denied, .restricted:
                globalData.setLocationAccess(granted: false)
            default:
                break
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get user location: \(error.localizedDescription)")
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().environmentObject(GlobalData())
    }
}
