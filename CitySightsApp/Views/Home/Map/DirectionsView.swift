//
//  DirectionsView.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 19.01.2023.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Businesses
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            HStack {
                BusinessDesc(business: business)
                
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name {
                    Link(destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!) {
                        Text("Open in Maps")
                    }
                }
            }
            .padding()
            
            DirectionsMap(business: business)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
