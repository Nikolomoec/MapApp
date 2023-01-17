//
//  BusinessSection.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 16.01.2023.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Businesses]
    
    var body: some View {
        Section(content: {
            ForEach(businesses) { business in
                
                NavigationLink {
                    BusinessDetail(business: business)
                } label: {
                    BusinessRow(business: business)
                }
            }
        }, header: {
            Business_section_header(title: title)
        })
    }
}

