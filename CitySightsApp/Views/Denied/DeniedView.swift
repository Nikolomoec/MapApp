//
//  DeniedView.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 19.01.2023.
//

import SwiftUI

struct DeniedView: View {
    
    let backColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack (spacing: 20) {
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to acces your location to provide the best restaurants and city sights near you. Without that information it will be imposible!")
            
            Spacer()
            
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                    
                }
            } label: {
                
                ZStack {
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .frame(height: 48)
                    Text("Go to Settings!")
                        .bold()
                        .foregroundColor(backColor)
                        .padding()
                }
            }
            .padding()
            
            Spacer()

        }
        .padding()
        .foregroundColor(.white)
        .ignoresSafeArea()
        .multilineTextAlignment(.center)
        .background(backColor)
    }
}

