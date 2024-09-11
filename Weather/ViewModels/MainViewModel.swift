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
    
    var currentWeather: Weather? {
        willSet {
            objectWillChange.send()
        }
    }
    
    var weatherList: [Weather] {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(locationRepo: LocationRepository = LocationRepository(), weatherRepo: WeatherRepository = WeatherRepository(), 
         viewState: ProgressState = ProgressState.none, currentWeather: Weather? = nil, weatherList: [Weather] = [], detailWeather: Weather = Weather.getDefaultValue()) {
        self.locationRepo = locationRepo
        self.weatherRepo = weatherRepo
        self.viewState = viewState
        self.currentWeather = currentWeather
        self.detailWeather = detailWeather
        self.weatherList = weatherList
        
        loadWeatherData(coordinates: Coordinate(latitude: 37.785834, longitude: -122.406417))//todo only for testing - remove
    }
    
    func setWeatherDetail(selectedWeather: Weather) {
        self.detailWeather = selectedWeather
        self.viewState = .displayDetail
    }
    
    func showList() {
        self.viewState = .displayWeatherList
        loadWeatherData(coordinates: Coordinate(latitude: 25.25, longitude: 55.28))//todo only for testing - remove
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
        weatherRepo.getCoordinatesWeather(at: coordinates, completionHandler: { [weak self] (currentWeather: Weather?, error: Error?) -> Void in
            guard let weakSelf = self else { return }
            
            if let currentWeather = currentWeather {
                weakSelf.currentWeather = currentWeather
                weakSelf.addLocatioaddLocationToList(weather: currentWeather)
                weakSelf.viewState = .displayWeatherList
            } else {
                weakSelf.viewState = .failureData
            }
        })
    }
    
    func addLocatioaddLocationToList(weather: Weather) {
        if let oldIndex = weatherList.firstIndex(where: { $0.coordinate.latitude == weather.coordinate.latitude && $0.coordinate.longitude == weather.coordinate.longitude}) {
            weatherList.remove(at: oldIndex)
        }
        weatherList.insert(weather, at: 0)
        //todo add coordinates to cache for later
    }
    
    static func getDefaultValue() -> MainViewModel {
        return MainViewModel()
    }
}
