//
//  CitySightsAppApp.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 15.01.2023.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ViewModel())
        }
    }
}
