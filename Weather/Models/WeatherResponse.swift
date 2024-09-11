//
//  WeatherResponse.swift
//  Weather
//
//  Created by Abdul rahim on 05/09/2024.
//

import Foundation

struct WeatherResponse: Codable {
    let id: Int
    let name: String
    let coordinate: CoordinateResponse
    let weatherDetail: [WeatherDetail]
    let mainValue: WeatherMainValue
    let visibility: Int
    let wind: Wind
    let clouds: WeatherClouds?
    let rain: WeatherRain?
    let snow: WeatherSnow?
    let date: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, visibility, wind, clouds, rain, snow
        case weatherDetail = "weather"
        case coordinate = "coord"
        case mainValue = "main"
        case date = "dt"
    }
    
    static func getDefaultValue() -> WeatherResponse {
        return WeatherResponse(id: 0, name: "Location Name", coordinate: CoordinateResponse.getDefaultValue(), weatherDetail: [], mainValue: WeatherMainValue.getDefaultValue(), visibility: 0, wind: Wind.getDefaultValue(), clouds: nil, rain: nil, snow: nil, date: 0)
    }
}

struct CoordinateResponse: Codable {
    let lon, lat: Double

    static func getDefaultValue() -> CoordinateResponse {
        return CoordinateResponse(lon: 0.0, lat: 0.0)
    }
}

struct WeatherRain: Codable {
    let oneHour: Int
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }

    static func getDefaultValue() -> WeatherRain {
        return WeatherRain(oneHour: 0)
    }
}

struct WeatherSnow: Codable {
    let oneHour: Int
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }

    static func getDefaultValue() -> WeatherSnow {
        return WeatherSnow(oneHour: 0)
    }
}

struct WeatherClouds: Codable {
    let all: Int

    static func getDefaultValue() -> WeatherClouds {
        return WeatherClouds(all: 0)
    }
}

struct WeatherDetail: Codable {
    let id: Int
    let main, description, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main, description
        case icon
    }
    
    static func getDefaultValue() -> WeatherDetail {
        return WeatherDetail(
            id: 0,
            main: "",
            description: "",
            icon: ""
        )
    }
}

struct WeatherMainValue: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    
    static func getDefaultValue() -> WeatherMainValue {
        return WeatherMainValue(
            temp: 0.0,
            feelsLike: 0.0,
            tempMin: 0,
            tempMax: 0,
            pressure: 0,
            humidity: 0
        )
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int?
    
    static func getDefaultValue() -> Wind {
        return Wind(speed: 0.0, deg: nil)
    }
}
