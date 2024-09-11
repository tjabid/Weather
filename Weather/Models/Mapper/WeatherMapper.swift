//
//  WeatherMapper.swift
//  Weather
//
//  Created by Abdul rahim on 11/09/2024.
//

import Foundation

class WeatherMapper {
    
    func parseCurrent(response: EndpointResponse?) -> Weather? {
        guard let value = response else {
            return nil
        }
        
        return Weather(
            name: value.location.name,
            country: value.location.country,
            coordinate: Coordinate(latitude:value.location.lat, longitude: value.location.lon),
            tempC: value.weatherResponse.tempC.toString(),
            feelslikeC: value.weatherResponse.feelslikeC.toString(),
            windKph: value.weatherResponse.windKph.toString(),
            windDegree: value.weatherResponse.windDegree.toString(),
            windDirection: value.weatherResponse.windDir,
            humidity: value.weatherResponse.humidity.toString(),
            cloud: value.weatherResponse.cloud.toString(),
            visibilityKM: value.weatherResponse.visKM.toString(),
            uv: value.weatherResponse.uv.toString(),
            description: value.weatherResponse.condition.text,
            lastUpdated: value.weatherResponse.lastUpdated,
            lastUpdatedEpoch: value.weatherResponse.lastUpdatedEpoch
        )
    }
    
    func parseForecast(response: EndpointResponse?) -> Weather {
        return Weather.getDefaultValue()
    }
}
