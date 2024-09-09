//
//  ContentView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .leading){
            if viewModel.viewState == .requestLocation {
                LocationRequestView() {
                    viewModel.requestLocation()
                }
            }
            
            if viewModel.viewState == .loading {
                LoadingStateView()
            }
            
            if viewModel.viewState  == .success {
                WeatherView(weather: viewModel.currentWeather).environmentObject(viewModel)
            }
            
            if viewModel.viewState  == .failureData {
                Text("Failed to load data!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            if viewModel.viewState  == .failureLocation {
                LocationRequestView() {
                    viewModel.requestLocation()
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    ContentView()
}
