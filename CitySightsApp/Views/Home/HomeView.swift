//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 16.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ViewModel
    @State var isMapShowing = false
    @State var selectedBusiness: Businesses?
    var body: some View {
        
        if model.sights.count != 0 || model.restaurants.count != 0 {
            
            NavigationStack {
                
                if !isMapShowing {
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "")
                            Spacer()
                            Button {
                                isMapShowing = true
                            } label: {
                                Text("Switch to a Map")
                                    .foregroundColor(.blue)
                            }
                            .tint(.black)

                        }
                        
                        Divider()
                        
                        BusinessList()
                    }
                    .padding([.horizontal, .top])
                } else {
                    ZStack (alignment: .top) {
                        
                        MapView(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                BusinessDetail(business: business)
                            }
                        
                        ZStack {
                        Rectangle ()
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .frame(height: 48)
                            HStack {
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "")
                                
                                Spacer()
                                
                                Button {
                                    self.isMapShowing = false
                                } label: {
                                    Text("Switch to List View")
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                }
            }
            
        } else {
            ProgressView()
        }
        
    }
}

