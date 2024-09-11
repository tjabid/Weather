//
//  WeatherView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    let viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Weather")
                .font(
                    Font.custom("SF Pro Display", size: 37).weight(.bold)
                )
            
            Text(weather?.name ?? "Not found")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text(weather?.mainValue.temp.toString() ?? "Not found")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            let list: [Weather] = viewModel.currentWeather//todo get list from vm
            let list: [Weather] = [
                Weather.getDefaultValue(),
                Weather(cityId: 0, name: "Location 1", coordinate: Coordinate.getDefaultValue(), description: "Cloudy", descriptionShort: "Cloudy", mainValue: WeatherMainValue.getDefaultValue(), visibility: 0, wind: Wind.getDefaultValue(), clouds: nil, rain: nil, snow: nil, date: 0),
                Weather(cityId: 0, name: "Location 2", coordinate: Coordinate.getDefaultValue(), description: "Snow", descriptionShort: "Snow", mainValue: WeatherMainValue.getDefaultValue(), visibility: 0, wind: Wind.getDefaultValue(), clouds: nil, rain: nil, snow: nil, date: 0)
            ]
            
            if list.isEmpty {
                Text("Not data found!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(list) { w in
                            WeatherCellView(weather: w) { selectedWeather in
                                self.viewModel.setWeatherDetail(selectedWeather: w)
                            }
                        }
                    }
                }
                .frame(height: .none)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .padding(20)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    WeatherView(viewModel: MainViewModel.getDefaultValue())
}
