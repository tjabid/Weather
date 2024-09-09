//
//  Utilities.swift
//  Weather
//
//  Created by Abdul rahim on 05/09/2024.
//

import Foundation

// Extension for rounded Double to 0 decimals
extension Double {
    func toString() -> String {
        return String(format: "%.0f", self)
    }
}

func log(message: Any, at tag: String = "Weather") {
    print("\(tag) \(message)")
}
