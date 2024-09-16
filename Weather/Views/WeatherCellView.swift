//
//  WeatherCellView.swift
//  Weather
//
//  Created by Abdul rahim on 10/09/2024.
//

import SwiftUI

struct WeatherCellView: View {
    let weather: Weather
    let itemClickedCallback: (Weather) -> Void
    let saveCallback: (Weather) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                VStack {
                    Text(weather.name)
                        .font(Font.bold(size: 25))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(weather.description)
                        .font(Font.medium())
                        .kerning(0.16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    let variation = "Feels like:\(weather.feelslikeC)° Humidity:\(weather.humidity)°"
                    Text(variation)
                        .font(Font.medium(size: 15))
                        .kerning(0.75)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }
                .padding(.vertical, 5)
                .frame(width: .none, height: 117, alignment: .topLeading)
                
                VStack {
                    Text(weather.tempC + "°")
                        .font(Font.light(size: 53))
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                    
                    
                    let image = if weather.savedLocation { "heart.fill" } else { "heart" }
                    Image(systemName: image)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                        .font(.system(size: 35))
                        .padding(.trailing)
                        .onTapGesture {
                            saveCallback(weather)
                        }
                }
                .frame(width: .none, height: 117, alignment: .trailing)
                .padding(.vertical, 5)
            }
            .frame(width: .none, height: 150)
            .padding(.horizontal, 20)
            .background(.white.opacity(0.1))
            .cornerRadius(16)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .inset(by: 0.25)
                    .stroke(.white.opacity(0.25), lineWidth: 0.5)
            )
            
            if weather.showForecast {
                HStack(spacing: 5) {
                    Image(systemName: "calendar")
                        .opacity(0.5)
                    Text("10-DAY FORECAST")
                        .font(Font.medium(size: 15))
                        .kerning(0.45)
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                
                LazyVStack(alignment: .leading) {
                    ForEach(weather.forecast) { f in
                        ForecastCellView(forecast: f)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .background(.white.opacity(0.1))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .inset(by: 0.25)
                            .stroke(.white.opacity(0.25), lineWidth: 0.5)
                    )
            }
        }
        .frame(width: .none, height: .none)
        .onTapGesture {
            itemClickedCallback(weather)
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    WeatherCellView(weather: Weather.getDefaultValue(), itemClickedCallback: { weather in
        
    }, saveCallback: { weather in })
}
