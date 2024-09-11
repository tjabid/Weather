//
//  ProgressState.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation

enum ProgressState {
    case none
    case requestLocation
    case loading
    case displayWeatherList
    case displayDetail
    case failureLocation
    case failureData
}
