//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 15.01.2023.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Businesses]()
    var total = 0
    var region = Region()
    
}

struct Region: Decodable {
    
    var center = Coordinates()
    
}
