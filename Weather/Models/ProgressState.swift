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
    case success
    case failureLocation
    case failureData
}
