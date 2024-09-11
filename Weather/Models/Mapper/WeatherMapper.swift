//
//  WeatherMapper.swift
//  Weather
//
//  Created by Abdul rahim on 11/09/2024.
//

import Foundation

class WeatherMapper {
    
    func parseCurrent(response: EndpointResponse?, forecast: [Forecast]? = nil) -> Weather? {
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
            lastUpdatedEpoch: value.weatherResponse.lastUpdatedEpoch,
            forecast: forecast ?? []
        )
    }
    
    func parseForecast(response: EndpointResponse?) -> Weather? {
        guard response != nil else {
            return nil
        }
        
        guard let forecast = response?.forecastResponse else {
            return nil
        }
        
        var forecastMapped: [Forecast] = []
        var counter = 0
        
        forecast.forecastday.forEach{ item in
            let n = Forecast(
                maxtempC: item.day.maxtempC.toString(),
                mintempC: item.day.mintempC.toString(),
                visibilityKM: item.day.avgvisKM.toString(),
                humidity: item.day.avghumidity.toString(),
                dailyWillItRain: item.day.dailyWillItRain == 1,
                dailyWillItSnow: item.day.dailyWillItSnow == 1,
                dailyChanceOfRain: item.day.dailyChanceOfRain.toString(),
                dailyChanceOfSnow: item.day.dailyChanceOfSnow.toString(),
                description: item.day.condition.text,
                date: formatDate(timestamp: item.dateEpoch),
                dateEpoch: item.dateEpoch
            )
            forecastMapped.insert(n, at: counter)
            counter += 1
        }
        
        
        return parseCurrent(response: response, forecast: forecastMapped)
    }
    
    func formatDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

        // Calculate today and tomorrow date
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        var dateString: String
        if Calendar.current.isDate(date, inSameDayAs: today) {
            dateString = "Today"
        } else if Calendar.current.isDate(date, inSameDayAs: tomorrow) {
            dateString = "Tomorrow"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, d MMM"
            
            dateString = dateFormatter.string(from: date)
        }
        return dateString
    }
}
