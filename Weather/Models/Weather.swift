//
//  Weather.swift
//  Weather
//
//  Created by Abdul rahim on 05/09/2024.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let coordinate: Coordinate
    let tempC: String
    let feelslikeC: String
    let windKph: String
    let windDegree: String
    let windDirection: String
    let humidity: String
    let cloud: String
    let visibilityKM: String
    let uv: String
    let description: String
    let lastUpdated: String
    let lastUpdatedEpoch: Int
    let forecast: [Forecast]
    var showForecast: Bool = false
    var savedLocation: Bool = false
    
    static func getDefaultValue() -> Weather {
        return Weather(name: "Location Name", country: "Country Name", coordinate: Coordinate.getDefaultValue(), tempC: "32", feelslikeC: "32", windKph: "32", windDegree: "10", windDirection: "NSW", humidity: "10", cloud: "10", visibilityKM: "5", uv: "5", description: "Cloudy", lastUpdated: "2024-09-11 10:00", lastUpdatedEpoch: 0, forecast: [], showForecast: false)
    }
}

struct WeatherCache: Codable {
    let name: String
    var showForecast: Bool
}
