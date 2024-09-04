//
//  ContentView.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .leading){
            if viewModel.viewState == .requestLocation {
                LocationRequestView() {
                    viewModel.requestLocation()
                }
            }
            
            if viewModel.viewState == .loading {
                LoadingStateView()
            }
            
            if viewModel.viewState  == .success {
                
            }
            
            if viewModel.viewState  == .failure {
                
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        
        
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
