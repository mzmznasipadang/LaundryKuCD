//
//  IamaTeapot.swift
//  LaundryKu
//
//  Created by Victor Chandra on 04/06/24.
//

import Foundation
import SwiftUI

struct IamaTeapotView: View {
    var body: some View {
        VStack {
            Text("418")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("I am a Teapot")
                .font(.title)
                .foregroundColor(.gray)
            
            Image("418")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 500, height: 500)
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
        .navigationBarTitle("I am a Teapot", displayMode: .inline)
    }
}

struct IamaTeapotView_Previews: PreviewProvider {
    static var previews: some View {
        IamaTeapotView()
    }
}
