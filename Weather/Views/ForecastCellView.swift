//
//  ForecastCellView.swift
//  Weather
//
//  Created by Abdul rahim on 11/09/2024.
//

import SwiftUI

struct ForecastCellView: View {
    let forecast: Forecast
    
    var body: some View {
        HStack(spacing: 5) {
            Text(forecast.date)
                .font(Font.custom("SF Pro Display", size: 18).weight(.semibold))
                .kerning(0.45)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if forecast.dailyWillItRain {
                Image(systemName: "cloud.rain").frame(alignment: .leading)
                Text(forecast.dailyChanceOfRain + "%")
                    .font(Font.custom("SF Pro Display", size: 15).weight(.medium))
                    .kerning(0.45)
            }
            
            else if forecast.dailyWillItSnow {
                Image(systemName: "cloud.snow").frame(alignment: .leading)
                Text(forecast.dailyChanceOfSnow + "%")
                    .font(Font.custom("SF Pro Display", size: 15).weight(.medium))
                    .kerning(0.45)
            }
            
            else  {
                Image(systemName: "humidity").frame(alignment: .leading)
                Text(forecast.humidity + "%")
                    .font(Font.custom("SF Pro Display", size: 15).weight(.medium))
                    .kerning(0.45)
            }
            
            
            Text("H: \(forecast.maxtempC)° L: \(forecast.mintempC)°")
                .font(Font.custom("SF Pro Display", size: 18).weight(.medium))
                .kerning(0.45)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
}
