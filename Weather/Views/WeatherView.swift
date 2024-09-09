//
//  WeatherView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    let weather: WeatherResponse?//todo intro local model & non nullable
    
    var body: some View {
        HStack {
            
            Text(weather?.name ?? "Not found")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text(weather?.mainValue.temp.toString() ?? "Not found")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
}

#Preview {
    WeatherView(weather: nil)
}
