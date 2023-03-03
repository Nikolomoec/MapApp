//
//  BusinessDesc.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 19.01.2023.
//

import SwiftUI

struct BusinessDesc: View {
    
    var business: Businesses
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text(business.name ?? "")
                .font(.largeTitle)
            
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { address in
                    Text(address)
                }
                
            }
            // Rating Stars
            
            Image("regular_\(business.rating ?? 0)")
        }
    }
}
