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
        
        checkInitailState()
    }
    
    func checkInitailState() {
        if self.weatherRepo.hasCachedItem() {
            self.viewState = .loading
            weatherRepo.getWeatherForCachedItems { [weak self] (weather: Weather?, error: Error?) -> Void in
                guard let weakSelf = self else { return }
                
                if let weatherResponse = weather {
                    weakSelf.addLocationToList(weather: weatherResponse)
                    weakSelf.viewState = .displayWeatherList
                } else {
                    weakSelf.viewState = .failureData
                }
            }
        } else {
            self.viewState = .requestLocation
        }
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
                    self.loadWeatherForecastData(query: "\(coordinates!.latitude),\(coordinates!.longitude)")
                } else {
                    self.viewState = ProgressState.failureLocation
                }
            }
        }
    }
    
    func loadWeatherData(query: String) {
        weatherRepo.getCoordinatesWeather(at: query, completionHandler: { [weak self] (currentWeather: Weather?, error: Error?) -> Void in
            guard let weakSelf = self else { return }
            
            if let currentWeather = currentWeather {
                weakSelf.addLocationToList(weather: currentWeather)
                weakSelf.viewState = .displayWeatherList
            } else {
                weakSelf.viewState = .failureData
            }
        })
    }
    
    func loadWeatherForecastData(query: String) {
        weatherRepo.getWeatherForecast(at: query, showForecast: true, completionHandler: { [weak self] (currentWeather: Weather?, error: Error?) -> Void in
            guard let weakSelf = self else { return }
            
            if let currentWeather = currentWeather {
                weakSelf.currentWeather = currentWeather
                weakSelf.currentWeather?.showForecast = true
                weakSelf.addLocationToList(weather: weakSelf.currentWeather!, index: 0)
                weakSelf.viewState = .displayWeatherList
            } else {
                weakSelf.viewState = .failureData
            }
        })
    }
    
    func addLocationToList(weather: Weather, index: Int? = nil) {
        if let oldIndex = weatherList.firstIndex(where: { $0.name == weather.name }) {
            weatherList.remove(at: oldIndex)
        }
        weatherList.insert(weather, at: index ?? weatherList.endIndex)
    }
    
    private var showSearchView: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    func isSearchView() -> Bool {
        return showSearchView
    }
    
    func setSearchView(showSearchView: Bool) {
        self.showSearchView = showSearchView
    }
    
    func loadWeatherDataFromSearchView(query: String) {
        viewState = .loading
        setSearchView(showSearchView: false)
        loadWeatherData(query: query)
    }
    
    func updateSavedLocation(name: String) {
        let oldViewState = viewState
        viewState = .loading
        if let newValue = weatherRepo.updateSavedLocation(name: name) {
            addLocationToList(weather: newValue)
            print("saving: \(name) \(newValue.savedLocation)")
        } else {
            print("saving: \(name) -----")
        }
        viewState = oldViewState
    }
    
    static func getDefaultValue() -> MainViewModel {
        return MainViewModel()
    }
}
