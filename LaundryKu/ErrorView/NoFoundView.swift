//
//  NoFoundView.swift
//  LaundryKu
//
//  Created by Victor Chandra on 04/06/24.
//

import Foundation
import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack {
            Text("404")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Page Not Found")
                .font(.title)
                .foregroundColor(.gray)
            
            Image("404")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .foregroundColor(.red)
                .padding()
            
            Button(action: {
                // Add action to go back to the home page or previous page
            }) {
                Text("Go Back")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationBarTitle("Not Found", displayMode: .inline)
    }
}

struct NotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NotFoundView()
    }
}
