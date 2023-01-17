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
    var body: some View {
        
        if model.sights.count != 0 || model.restaurants.count != 0 {
            
            NavigationStack {
                
                if !isMapShowing {
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Text("Button switch")
                        }
                        
                        Divider()
                        
                        BusinessList()
                    }
                    .padding([.horizontal, .top])
                } else {
                    
                    
                    
                }
            }
            
        } else {
            ProgressView()
        }
        
    }
}

