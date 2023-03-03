//
//  OnboardingView.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 19.01.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model: ViewModel
    @State var screen = 0
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private var green = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
         VStack {
            
            TabView(selection: $screen) {
            
                VStack (spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City Sights helps you the best sights in your city!")
                        .multilineTextAlignment(.center)
                }
                .tag(0)
                .foregroundColor(.white)
                VStack (spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We'll show you the best restaurants, sights and more, based on your location!")
                        .multilineTextAlignment(.center)
                }
                .tag(1)
                .foregroundColor(.white)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            
            
            Button {
                
                if screen == 0 {
                    screen = 1
                } else {
                    model.requestGeolocation()
                }
                
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text(screen == 0 ? "Next" : "Get my Location")
                        .bold()
                        .padding()
                }
            }
            .tint(screen == 0 ? blue : green)
            .padding()
            .padding(.bottom, 35)
        }
         .ignoresSafeArea()
         .background(screen == 0 ? blue : green)
        
    }
    
}

