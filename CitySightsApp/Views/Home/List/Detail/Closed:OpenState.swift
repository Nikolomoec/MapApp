//
//  Closed:OpenState.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 17.01.2023.
//

import SwiftUI

struct Closed_OpenState: View {
    
    var state: Bool
    
    var body: some View {
        ZStack (alignment: .leading) {
            Rectangle()
                .foregroundColor(state ? .gray : .blue)
                .frame(height: 36)
            Text(state ? "Closed" : "Open")
                .foregroundColor(.white)
                .bold()
                .padding(.leading)
        }
    }
}

