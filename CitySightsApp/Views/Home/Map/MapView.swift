//
//  MapView.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 17.01.2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var model: ViewModel
    
    var location: [MKPointAnnotation] {
        
        var anotations = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                // Create a single Pin
                var a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                anotations.append(a)
                
            }
        }
        
        return anotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        uiView.removeAnnotations(uiView.annotations)
        
        uiView.showAnnotations(location, animated: true)
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
