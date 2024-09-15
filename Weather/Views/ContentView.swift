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
            
            if viewModel.viewState == .loading || viewModel.viewState  == .none {
                LoadingStateView()
            }
            
            if viewModel.viewState  == .displayWeatherList {
                if !viewModel.weatherList.isEmpty {
                    WeatherView(viewModel: viewModel)
                }
            }
            
            if viewModel.viewState  == .displayDetail {
                WeatherDetailView(viewModel: viewModel)
            }
            
            if viewModel.viewState  == .failureData {
                DataLoadFailureView {
                    viewModel.showList()
                }
            }
            
            if viewModel.viewState  == .failureLocation {
                LocationRequestView() {
                    viewModel.requestLocation()
                }
            }
            
            if viewModel.isSearchView() {
                SearchCityView(viewModel: viewModel) {
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    ContentView()
}
