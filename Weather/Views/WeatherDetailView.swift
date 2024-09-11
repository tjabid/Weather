//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Abdul rahim on 10/09/2024.
//

import SwiftUI

struct WeatherDetailView: View {
    let viewModel: MainViewModel
    
    var body: some View {
        let weather = viewModel.detailWeather
        
        ScrollView(.vertical) {
            VStack {
                Text(weather.name)
                    .font(Font.custom("SF Pro Display", size: 37))
                    .multilineTextAlignment(.center)
                
                
//                if let description = weather.description {
                    Text(weather.description)
                        .font(Font.custom("SF Pro Display", size: 22)
                            .weight(.medium))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
//                }
                
                HStack(spacing: 5) {
                    Image(systemName: "thermometer.medium")
                        .opacity(0.5)
                        .padding(.leading)
                    Text("TEMPERATURE")
                        .font(
                            Font.custom("SF Pro Display", size: 12)
                                .weight(.medium)
                        )
                        .kerning(0.45)
                        .foregroundColor(.white)
                        .opacity(0.5)
                    
                    Text(weather.tempC + "°C")
                        .font(Font.custom("SF Pro Display", size: 35))
                        .padding(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(.white)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white.opacity(0.1))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .inset(by: 0.25)
                        .stroke(.white.opacity(0.25), lineWidth: 0.5)
                )
                
                Grid(horizontalSpacing: 5) {
                    GridRow {
                        GenericDetailCellView(label: "FEELS LIKE", icon: "thermometer.high", value: weather.feelslikeC, unit: "°C")
                        GenericDetailCellView(label: "WIND", icon: "wind", value: weather.windKph, unit: "KM/H")
                    }
                    GridRow {
                        GenericDetailCellView(label: "VISIBILITY", icon: "sun.dust.circle", value: weather.visibilityKM, unit: "KM")
                        GenericDetailCellView(label: "HUMIDITY", icon: "humidity", value: weather.humidity, unit: "%")
                    }
                    GridRow {
                        GenericDetailCellView(label: "CLOUDS", icon: "cloud.fill", value: weather.cloud, unit: "%")
                        GenericDetailCellView(label: "UV", icon: "thermometer.brakesignal", value: weather.uv, unit: "INDEX")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .padding(20)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .onTapGesture {
            viewModel.showList()
        }
    }
}

#Preview {
    WeatherDetailView(viewModel: MainViewModel.getDefaultValue())
}
