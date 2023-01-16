//
//  LaunchView.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 15.01.2023.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
       
        if model.locationState == .notDetermined {
            
        } else if model.locationState == .authorizedAlways || model.locationState == .authorizedWhenInUse {
            
            HomeView()
            
        } else {
            
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ViewModel())
    }
}
