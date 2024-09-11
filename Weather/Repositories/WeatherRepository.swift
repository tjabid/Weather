//
//  WeatherRepository.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation

class WeatherRepository {
    
    let remoteDataSource = WeatherRemoteDataSource()
    
    func getCoordinatesWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        remoteDataSource.getCoordinatesWeather(at: coordinate, completionHandler:completion)
    }
    
    func getWeatherForecast(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        remoteDataSource.getWeatherForecast(at: coordinate, completionHandler:completion)
    }
    
}
