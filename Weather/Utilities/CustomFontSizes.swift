//
//  CustomFontSizes.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation
import SwiftUI


extension Font {
    
    static func medium(size: CGFloat = 16) -> Font {
        return Font.custom("SF Pro Display", size: size).weight(.medium)
    }
    
    static func bold(size: CGFloat = 24) -> Font {
        return Font.custom("SF Pro Display", size: size).weight(.bold)
    }
    
    static func light(size: CGFloat = 24) -> Font {
        return Font.custom("SF Pro Display", size: size).weight(.light)
    }
    
    static func semibold(size: CGFloat = 24) -> Font {
        return Font.custom("SF Pro Display", size: size).weight(.semibold)
    }
}

