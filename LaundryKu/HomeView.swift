//
//  HomeView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        TabView {
            HomeTab()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomeTab: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Center BannerView by making it take full width and aligning its content to center
                    BannerView()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Our Services")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.leading, .top], 15)
                    
                    ServiceGridView()
                    
                    Text("Explore Nearby Laundries")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.leading, .top], 15)
                    
                    NearbyLaundriesView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Your Location")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Button(action: {
                            // Location change action
                        }) {
                            HStack {
                                Text("Jalan Dimana Hatiku Senang")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 15)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "bell")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// BannerView
struct BannerView: View {
    var body: some View {
        Image("laundry_banner")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 160)
            .clipped()
            .cornerRadius(10)
            .padding(.top, 10)
            .shadow(radius: 5)
    }
}

// ServiceGrid
struct ServiceGridView: View {
    let services = ["Standard", "Express", "Premium", "Delicate", "Bedding", "Wool", "Stained", "Bingung"]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
            ForEach(services, id: \.self) { service in
                VStack {
                    Image(service.lowercased())  // Ensure these images are in your assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    Text(service)
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
        }
        .padding([.leading, .trailing], 15)
        .padding(.bottom, 20)
    }
}

// Nearby Laundry
struct NearbyLaundriesView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                LaundryCard(name: "Gachor Club", distance: "1.8 km", rating: "4.9", type: "Standard", location: "Moas, Alam Sutera", imageName: "gachor_club")
                LaundryCard(name: "Zeus Laundry", distance: "∞ km", rating: "∞", type: "Premium", location: "Lord Zeus, Alam Awan", imageName: "zeus_laundry")
            }
            HStack(spacing: 15) {
                LaundryCard(name: "Kiron Mishi Laundry", distance: "2.5 km", rating: "4.9", type: "Express", location: "Pasar 8, Alam Sutera", imageName: "kiron_mishi_laundry")
                LaundryCard(name: "Gachor Club", distance: "1.8 km", rating: "4.9", type: "Standard", location: "Moas, Alam Sutera", imageName: "gachor_club")
            }
        }
        .padding([.leading, .trailing, .bottom], 15)
    }
}

// Laundry Card View
struct LaundryCard: View {
    var name: String
    var distance: String
    var rating: String
    var type: String
    var location: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Image
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 160, height: 100)
                    .background(
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160, height: 100)
                            .clipped()
                    )
                    .cornerRadius(10)
                
                // Type badge
                HStack {
                    Text(type)
                        .font(Font.custom("SF Pro Display", size: 10).weight(.medium))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .padding([.top, .leading], 8)
                }
            }
            
            // Bottom Text
            VStack(alignment: .leading, spacing: 4) {
                Text(distance)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
                Text(name)
                    .foregroundColor(Color.white)
                    .lineLimit(2)
                
                Text(location)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(rating)
                        .font(Font.custom("SF Pro Display", size: 10).weight(.medium))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.accentColor)
            .cornerRadius(10)
            .frame(width: 160)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.top, .bottom], 10)
    }
}

struct ProfileTab: View {
    var body: some View {
        NavigationLink(destination: ProfileView()) {
            Text("Go to Profile")
                .foregroundColor(.blue)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(GlobalData())
    }
}
