//
//  Utilities.swift
//  Weather
//
//  Created by Abdul rahim on 05/09/2024.
//

import Foundation

// Extension for Double
extension Double {
    func toString() -> String {
        return String(format: "%.0f", self)
    }
}

// Extension for Int
extension Int {
    func toString() -> String {
        return String(format: "%d", self)
    }
}

func log(message: Any, at tag: String = "Weather") {
    print("\(tag) \(message)")
}
