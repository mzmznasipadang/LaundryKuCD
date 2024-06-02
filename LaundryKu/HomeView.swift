//
//  HomeView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var globalData: GlobalData
    var body: some View {
        TabView {
            HomeTab()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
//            PromotionsView()
//                .tabItem {
//                    Label("Promo", systemImage: "tag.fill")
//                }
//            OrdersView()
//                .tabItem {
//                    Label("Orders", systemImage: "cart.fill")
//                }
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.fill")
//                }
        }
    }
}

struct HomeTab: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Location or Laundry Place", text: .constant(""))
                            .padding(8)
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()

                    // Banner
                    ZStack {
                        Image("laundry_banner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                        VStack {
                            Spacer()
                            Text("Your one stop laundry services\nMau pasang iklan slot? klik disini!")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(height: 150)
                        .background(Color.black.opacity(0.3))
                    }
                    .cornerRadius(8)
                    .padding([.leading, .trailing])

                    // Services
                    Text("Services")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.leading, .top])
                    
                    let services = ["Standard", "Express", "Premium", "Delicate", "Bedding", "Wool", "Stained", "Kecepirit"]
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                        ForEach(services, id: \.self) { service in
                            VStack {
                                Image(service.lowercased())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                Text(service)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding([.leading, .trailing])

                    // Nearby Laundries
                    Text("Nearby Laundries")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.leading, .top])
                    
                    VStack {
                        HStack {
                            LaundryCard(name: "Gachor Club", distance: "1.8 km", rating: "4.9", type: "Standard", location: "Moas, Alam Sutera", imageName:"gachor_club")
                            LaundryCard(name: "Zeus Laundry", distance: "∞ km", rating: "∞", type: "Premium", location: "Lord Zeus, Alam Awan",imageName: "zeus_laundry")
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                }
            }
            .navigationBarTitle("LaundryKu", displayMode: .inline)
            .navigationBarItems(trailing: Image(systemName: "heart").foregroundColor(.blue))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LaundryCard: View {
    var name: String
    var distance: String
    var rating: String
    var type: String
    var location: String
    var imageName: String

    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .clipped()
                .cornerRadius(8)
            
            Text(name)
                .font(.headline)
                .padding(.top, 5)
            Text(location)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Text(distance)
                    .font(.subheadline)
                Spacer()
                Text(type)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(rating)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
