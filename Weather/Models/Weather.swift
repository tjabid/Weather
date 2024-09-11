//
//  Weather.swift
//  Weather
//
//  Created by Abdul rahim on 05/09/2024.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let cityId: Int
    let name: String
    let coordinate: Coordinate
    let description: String?
    let descriptionShort: String?
    let mainValue: WeatherMainValue
    let visibility: Int
    let wind: Wind
    let clouds: WeatherClouds?
    let rain: WeatherRain?
    let snow: WeatherSnow?
    let date: Int
    
    static func getDefaultValue() -> Weather {
        return Weather(cityId: 0, name: "Location Name", coordinate: Coordinate.getDefaultValue(), description: "Mostly Sunny", descriptionShort: "Sunny", mainValue: WeatherMainValue.getDefaultValue(), visibility: 0, wind: Wind.getDefaultValue(), clouds: nil, rain: nil, snow: nil, date: 0)
    }
}
