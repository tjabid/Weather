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
            
            let list: [Weather] = viewModel.weatherList
            
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
