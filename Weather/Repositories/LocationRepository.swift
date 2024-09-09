//
//  LocationRepository.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation
import CoreLocation

class LocationRepository: NSObject, CLLocationManagerDelegate {
    // Creating an instance of CLLocationManager, the framework we use to get the coordinates
    private let manager = CLLocationManager()
    
    var currentCoordinates: Coordinate?
    var isLoading = false
    
    override init() {
        super.init()
        
        // Assigning a delegate to our CLLocationManager instance
        manager.delegate = self
    }
    
    private var completionCallback: (Coordinate?) -> Void = { c in
    }
    
    func requestLocation(completionHandler completion:  @escaping (Coordinate?) -> Void) {
        isLoading = true
        manager.requestLocation()
        completionCallback = completion
    }
    
    // Set the location coordinates to the location variable
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latitude = locations.first?.coordinate.latitude ?? 0
        let longitude = locations.first?.coordinate.longitude ?? 0
        
        currentCoordinates = Coordinate(latitude: latitude, longitude: longitude)
        
        isLoading = false
        completionCallback(currentCoordinates)
        print("Success getting location", currentCoordinates ?? 0)
    }
    
    
    // This function will be called if we run into an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
        currentCoordinates = nil
        completionCallback(currentCoordinates)
    }
}
