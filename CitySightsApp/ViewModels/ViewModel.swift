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
    
    override init() {
        
        super.init()
        
        locationManager.delegate = self
        
        // Request user for Location Info (also add property in info plst)
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: - Location Manager Delegate Methods
    
    // Checking what user tapped
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
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
            //getBusinesses("art", userLocation!)
            getBusinesses("restuarants", userLocation!)
        }
    }
    
    func getBusinesses(_ category: String, _ location: CLLocation) {
        
//        let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6")
        
        var urlCopmonents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlCopmonents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "index", value: String(6)),
            URLQueryItem(name: "categories", value: category)
        ]
        
        let url = urlCopmonents?.url
        
        if let url = url {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer zlq9YREKlQ3LzQ0TUUuYp-2wRHDMvBe_nx214D-ubi0w2H_ucNE-X0CfqcWyekpNi9DDE8iTQfrOfWJVhTeVTf2ccKfc9jwq3DKOV_h_RqrLQ-Y5ifT1DrEB8D_EY3Yx", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, responce, error in
                guard error == nil else {return}
                
                print(responce)
                
            }
            dataTask.resume()
        }
    }
}
