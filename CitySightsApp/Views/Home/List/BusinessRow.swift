//
//  BusinessRow.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 16.01.2023.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Businesses
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                //Image Url
                let UiImageMain = UIImage(data: business.imageData ?? Data())
                Image(uiImage: UiImageMain ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                VStack (alignment: .leading) {
                    
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format:"%.1f km away", (business.distance ?? 0)/1000))
                        .font(.caption)
                    
                }
                Spacer()
                
                VStack (alignment: .leading) {
                    
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
                
            }
            DashedDivider()
                .padding(.vertical)
        }
        .tint(.black)
    }
}

