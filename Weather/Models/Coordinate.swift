//
//  LocationCoordinate.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation

struct Coordinate: Codable {
    let latitude, longitude: Double
    
    static func getDefaultValue() -> Coordinate {
        return Coordinate(latitude: 0, longitude: 0)
    }
}
