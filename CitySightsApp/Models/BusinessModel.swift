//
//  Model.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 15.01.2023.
//

import Foundation

class Businesses: Decodable, Identifiable, ObservableObject {
    
    @Published var imageData: Data?
    
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinates?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    
    func getImageUrl() {
        
        guard imageUrl != nil else {return}
        
        if let url = URL(string: imageUrl!) {
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { data, respnoce, error in
                
                if error == nil {
                    
                    DispatchQueue.main.async {
                        self.imageData = data!
                    }
                }
            }
            dataTask.resume()
        }
        
    }
    
}

struct Category: Decodable {
    
    var alias: String?
    var title: String?
    
}

struct Coordinates: Decodable {
    
    var latitude: Double?
    var longitude: Double?
    
}

struct Location: Decodable {
    
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var state: String?
    var displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        
        case address1
        case address2
        case address3
        case city
        case state
    }
}

