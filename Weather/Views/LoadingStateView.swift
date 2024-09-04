//
//  LoadingStateView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingStateView()
}
