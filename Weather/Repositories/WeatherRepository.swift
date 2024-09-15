//
//  WeatherRepository.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation

typealias CurrentWeatherCompletionHandler = (Weather?, Error?) -> Void

protocol WeatherRepositoryProtocol {
    func hasCachedItem() -> Bool
    func getWeatherForCachedItems(completionHandler: @escaping (Weather?, Error?) -> Void)
    func getCoordinatesWeather(at query: String, completionHandler: @escaping (Weather?, Error?) -> Void)
    func getWeatherForecast(at query: String, showForecast: Bool, completionHandler: @escaping (Weather?, Error?) -> Void)
    func updateSavedLocation(name: String) -> Weather?
}

class WeatherRepository: WeatherRepositoryProtocol {
    
    let remoteDataSource: WeatherRemoteDataSourceProtocol
    let localDataSource: WeatherLocalDataSourceProtocol
    
    init(remoteDataSource: WeatherRemoteDataSourceProtocol = WeatherRemoteDataSource(), localDataSource: WeatherLocalDataSourceProtocol = WeatherLocalDataSource()) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func hasCachedItem() -> Bool {
        return localDataSource.hasCachedItem()
    }
    
    func getWeatherForCachedItems(completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        localDataSource.getCached().forEach { item in
            if item.showForecast {
                getWeatherForecast(at: item.name, showForecast: true) { (currentWeather: Weather?, error: Error?) -> Void in
                    if var weather = currentWeather {
                        weather.savedLocation = true
                        completion(weather, nil)
                        return
                    }
                    completion(currentWeather, error)
                }
            } else {
                getCoordinatesWeather(at: item.name) { (currentWeather: Weather?, error: Error?) -> Void in
                    if var weather = currentWeather {
                        weather.savedLocation = true
                        completion(weather, nil)
                        return
                    }
                    completion(currentWeather, error)
                }
            }
        }
    }
    
    func getCoordinatesWeather(at query: String, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        if let loaded = localDataSource.getLoadedWeather(query: query, showForecast: false) {
            completion(loaded, nil)
            return
        }
        
        remoteDataSource.getCoordinatesWeather(at: query, completionHandler: { (currentWeather: Weather?, error: Error?) -> Void in
            if currentWeather != nil {
                self.localDataSource.saveLoadedItem(item: currentWeather!)
            }
            completion(currentWeather, error)
        })
    }
    
    func getWeatherForecast(at query: String, showForecast: Bool, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        if let loaded = localDataSource.getLoadedWeather(query: query, showForecast: showForecast) {
            completion(loaded, nil)
            return
        }
        
        remoteDataSource.getWeatherForecast(at: query, showForecast: showForecast, completionHandler: { (currentWeather: Weather?, error: Error?) -> Void in
            if let cache = currentWeather {
                self.localDataSource.saveLoadedItem(item: cache)
            }
            completion(currentWeather, error)
        })
    }
    
    func updateSavedLocation(name: String) -> Weather? {
        return localDataSource.updateSavedLocation(name: name)
    }
}
