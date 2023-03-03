//
//  DirectionsMap.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 19.01.2023.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ViewModel
    var business: Businesses
    
    // Start Coordinates for Directions
    var start: CLLocationCoordinate2D {
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    // End Coordinates for Directions
    var end: CLLocationCoordinate2D {
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else {
            return CLLocationCoordinate2D()
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        // Create Map
        let map = MKMapView()
        map.delegate = context.coordinator
        
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        // Create Directions request
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        // Create Directions Object
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if error == nil && response != nil {
                for route in response!.routes {
                    map.addOverlay(route.polyline)
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                }
            }
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        map.addAnnotation(annotation)
        
        return map
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    static func dismantleUIView(_ uiView: MKMapView, Coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    //MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
}

class Coordinator: NSObject, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 5
        return renderer
    }
    
}
