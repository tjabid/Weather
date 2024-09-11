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
                
                if let description = weather.description ?? weather.descriptionShort {
                    Text(description)
                        .font(Font.custom("SF Pro Display", size: 22)
                            .weight(.medium))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                }
                
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
                    
                    Text(weather.mainValue.temp.toString() + "°")
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
                        GenericDetailCellView(label: "LOW TEMPERATURE", icon: "thermometer.low", value: weather.mainValue.tempMin.toString() + "°")
                        GenericDetailCellView(label: "HIGH TEMPERATURE", icon: "thermometer.high", value: weather.mainValue.tempMax.toString() + "°")
                    }
                    GridRow {                        
                        GenericDetailCellView(label: "WIND", icon: "wind", value: weather.wind.speed.toString(), unit: "meter/sec")
                        GenericDetailCellView(label: "HUMIDITY", icon: "humidity", value: weather.mainValue.humidity.toString(), unit: "%")
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
