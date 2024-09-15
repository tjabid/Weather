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
                .font(Font.semibold(size: 18))
                .kerning(0.45)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if forecast.dailyWillItRain {
                Image(systemName: "cloud.rain").frame(alignment: .leading)
                Text(forecast.dailyChanceOfRain + "%")
                    .font(Font.medium(size: 15))
                    .kerning(0.45)
            }
            
            else if forecast.dailyWillItSnow {
                Image(systemName: "cloud.snow").frame(alignment: .leading)
                Text(forecast.dailyChanceOfSnow + "%")
                    .font(Font.medium(size: 15))
                    .kerning(0.45)
            }
            
            else  {
                Image(systemName: "humidity").frame(alignment: .leading)
                Text(forecast.humidity + "%")
                    .font(Font.medium(size: 15))
                    .kerning(0.45)
            }
            
            
            Text("H: \(forecast.maxtempC)° L: \(forecast.mintempC)°")
                .font(Font.medium(size: 18))
                .kerning(0.45)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
}

#Preview {
    ForecastCellView(forecast: Forecast.getDefaultValue())
}
