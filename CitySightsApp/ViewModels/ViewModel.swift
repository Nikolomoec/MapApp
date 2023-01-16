//
//  ViewModel.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 15.01.2023.
//

import Foundation
import CoreLocation

class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @Published var locationState = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Businesses]()
    @Published var sights = [Businesses]()
    
    override init() {
        
        super.init()
        
        locationManager.delegate = self
        
        // Request user for Location Info (also add property in info plst)
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: - Location Manager Delegate Methods
    
    // Checking what user tapped
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        locationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == .denied {
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Give us location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            // Stops Updating Location
            locationManager.stopUpdatingLocation()
            
            // Sending Location to Yelp API
            getBusinesses(Constants.sightsKey, userLocation!)
            getBusinesses(Constants.restuarantsKey, userLocation!)
        }
    }
    
    func getBusinesses(_ category: String, _ location: CLLocation) {
        
//        let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6")
        
        var urlCopmonents = URLComponents(string: Constants.apiUrl)
        urlCopmonents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "limit", value: String(6)),
            URLQueryItem(name: "categories", value: category)
        ]
        
        let url = urlCopmonents?.url
        
        if let url = url {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, responce, error in
                guard error == nil else {return}
                
                // Parse data
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(BusinessSearch.self, from: data!)
                    // Sort Data (km away)
                    var businesses = data.businesses
                    businesses.sorted { b1, b2 in
                        return b1.distance ?? 0 < b2.distance ?? 0
                    }
                    // Image function (url = actual Image)
                    for b in businesses {
                        b.getImageUrl()
                    }
                    DispatchQueue.main.async {
//                        if category == Constants.sightsKey {
//                            self.sights = data.businesses
//                        } else if category == Constants.restuarantsKey {
//                            self.restaurants = data.businesses
//                        }
                        switch category {
                        case Constants.sightsKey:
                            self.sights = businesses
                        case Constants.restuarantsKey:
                            self.restaurants = businesses
                        default:
                            break
                        }
                    }
                }
                catch {
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
}
