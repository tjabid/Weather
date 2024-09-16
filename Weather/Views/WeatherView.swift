//
//  WeatherView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @State private var searchText = ""
    
    let viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Weather")
                .font(Font.bold())
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            // Search bar
            Text("Search city")
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            TextField("Search for a city", text: $searchText)
                .padding(8)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white.opacity(1))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 0.25)
                        .stroke(.white.opacity(0.25), lineWidth: 0.5)
                ).onTapGesture(perform: {
                    viewModel.setSearchView(showSearchView: true)
                })
            
            let list: [Weather] = viewModel.weatherList
            
            if list.isEmpty {
                Text("No data found!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(list) { w in
                            WeatherCellView(weather: w, itemClickedCallback: { selectedWeather in
                                self.viewModel.setWeatherDetail(selectedWeather: w)
                            }, saveCallback: { selectedWeather in
                                self.viewModel.updateSavedLocation(name: selectedWeather.name)
                            })
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
