//
//  DataLoadFailureView.swift
//  Weather
//
//  Created by Abdul rahim on 14/09/2024.
//

import SwiftUI

struct DataLoadFailureView: View {
    let backClicled: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            TopView(title: "Weather") {
                backClicled()
            }
            
            Text("Failed to load data!")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .padding(20)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    DataLoadFailureView{}
}
