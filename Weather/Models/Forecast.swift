//
//  Forecast.swift
//  Weather
//
//  Created by Abdul rahim on 11/09/2024.
//

import Foundation


struct Forecast: Identifiable {
    let id = UUID()
    
    let maxtempC, mintempC: String
    
    let visibilityKM: String
    let humidity: String
    let dailyWillItRain, dailyWillItSnow: Bool
    let dailyChanceOfRain, dailyChanceOfSnow: String
    
    let description: String
    
    let date: String
    let dateEpoch: Int
    
    static func getDefaultValue() -> Forecast {
        return Forecast(maxtempC: "40", mintempC: "30", visibilityKM: "10", humidity: "5", dailyWillItRain: false, dailyWillItSnow: false, dailyChanceOfRain: "0", dailyChanceOfSnow: "0", description: "Cloudy", date: "2024-09-11", dateEpoch: 0)
    }
}
