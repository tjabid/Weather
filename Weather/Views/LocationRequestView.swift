//
//  LocationRequestView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI
import CoreLocationUI

struct LocationRequestView: View {
    
    let requestLocationCallback: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Current location pemission")
                    .bold()
                    .font(.title)
                
                Text("Kindly provide your location to receive the current weather update for your area.")
                    .padding()
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
            
            // native button for request location
            LocationButton(.shareCurrentLocation) {
                self.requestLocationCallback()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LocationRequestView() {
        
    }
}
