//
//  MainViewModel.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    //let client = OpenweatherAPIClient()
    //@EnvironmentObject var locationManager: LocationManager
    //let manager = CLLocationManager()
    
    var viewState: ProgressState = ProgressState.requestLocation {
        willSet {
            objectWillChange.send()
        }
    }
    
    func requestLocation() {
        viewState = ProgressState.loading
        //        manager.requestLocation()
    }
}
