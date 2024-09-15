//
//  GenericDetailCellView.swift
//  Weather
//
//  Created by Abdul rahim on 10/09/2024.
//

import SwiftUI

struct GenericDetailCellView: View {
    let label: String
    let icon: String
    let value: String
    var unit: String? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .opacity(0.5)
                Text(label)
                    .font(Font.medium(size: 12))
                    .kerning(0.45)
                    .foregroundColor(.white)
                    .opacity(0.5)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 5) {
                Text(value)
                    .font(Font.medium(size: 35))
                    .frame(maxWidth: .none, alignment: .leading)
                
                if unit != nil {
                    Text(unit!)
                        .font(Font.medium(size: 12))
                        .frame(maxWidth: .none, maxHeight: .infinity, alignment: .bottom)
                        .offset(y: -6)
                        .kerning(0.45)
                        .foregroundColor(.white)
                        .opacity(0.5)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(width: .none, height: .none)
        .background(.white.opacity(0.1))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 0.25)
                .stroke(.white.opacity(0.25), lineWidth: 0.5)
        )
    }
}

#Preview {
    GenericDetailCellView(label: "Label", icon: "thermometer.medium", value: "Value")
}
