//
//  MainViewModel.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    let locationRepo: LocationRepository
    let weatherRepo: WeatherRepository
    var detailWeather: Weather
    
    var viewState: ProgressState = ProgressState.none {
        willSet {
            objectWillChange.send()
        }
    }
    
    var currentWeather: WeatherResponse? {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(locationRepo: LocationRepository = LocationRepository(), weatherRepo: WeatherRepository = WeatherRepository(), 
         viewState: ProgressState = ProgressState.none, currentWeather: WeatherResponse? = nil, detailWeather: Weather = Weather.getDefaultValue()) {
        self.locationRepo = locationRepo
        self.weatherRepo = weatherRepo
        self.viewState = viewState
        self.currentWeather = currentWeather
        self.detailWeather = detailWeather
        
        loadWeatherData(coordinates: Coordinate(latitude: 37.785834, longitude: -122.406417))//todo only for testing - remove
    }
    
    func setWeatherDetail(selectedWeather: Weather) {
        self.detailWeather = selectedWeather
        self.viewState = .displayDetail
    }
    
    func showList() {
        self.viewState = .displayWeatherList
    }
    
    func requestLocation() {
        viewState = ProgressState.loading
        
        locationRepo.requestLocation() { coordinates in
            if self.locationRepo.isLoading == false {
                if coordinates != nil {
                    self.loadWeatherData(coordinates: coordinates!)
                } else {
                    self.viewState = ProgressState.failureLocation
                }
            }
        }
    }
    
    func loadWeatherData(coordinates: Coordinate) {
        weatherRepo.getCoordinatesWeather(at: coordinates, completionHandler: { [weak self] (currentWeather: WeatherResponse?, error: Error?) -> Void in
            guard let weakSelf = self else { return }
            
            if let currentWeather = currentWeather {
                weakSelf.currentWeather = currentWeather
                weakSelf.viewState = .displayWeatherList
            } else {
                weakSelf.viewState = .failureData
            }
        })
    }
    
    static func getDefaultValue() -> MainViewModel {
        return MainViewModel()
    }
}
