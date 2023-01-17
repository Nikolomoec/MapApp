//
//  Business section header.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 16.01.2023.
//

import SwiftUI

struct Business_section_header: View {
    
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
        Text(title)
            .font(.headline)
    }
    }
}
