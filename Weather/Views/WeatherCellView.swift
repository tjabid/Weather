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
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: .none, height: 150)
                .background(.white)
                .cornerRadius(16)
                .opacity(0.1)
            
            HStack(spacing: 5) {
                VStack {
                    Text(weather.name)
                        .font(
                            Font.custom("SF Pro Display", size: 25)
                                .weight(.bold)
                        )
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text("Seongnam-si")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
                                .weight(.medium)
                        )
                        .kerning(0.16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    let description = weather.description ?? weather.descriptionShort ?? "Not Available"
                    Text(description)
                        .font(
                            Font.custom("SF Pro Display", size: 16)
                                .weight(.medium)
                        )
                        .kerning(0.16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }
                .padding(.vertical, 5)
                .frame(width: .none, height: 117, alignment: .topLeading)
                
                VStack {
                    Text(weather.mainValue.temp.toString() + "°")
                        .font(
                            Font.custom("SF Pro Display", size: 53)
                                .weight(.light)
                        )
                        .kerning(5.565)
                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                    
                    let variation = "H:\(weather.mainValue.tempMax)° L:\(weather.mainValue.tempMin)°"
                    Text(variation)
                        .font(
                            Font.custom("SF Pro Display", size: 15)
                                .weight(.medium)
                        )
                        .kerning(0.75)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                }
                .frame(width: .none, height: 117, alignment: .trailing)
                .padding(.vertical, 5)
            }
            .frame(width: .none, height: 150)
            .padding(.horizontal, 20)
        }
        .frame(width: .none, height: 150)
        .onTapGesture {
            itemClickedCallback(weather)
        }
    }
}

#Preview {
    WeatherCellView(weather: Weather.getDefaultValue()) { weather in
        
    }
}
