//
//  TopView.swift
//  Weather
//
//  Created by Abdul rahim on 14/09/2024.
//

import SwiftUI

struct TopView: View {
    let title: String
    let backClicked: () -> Void
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "chevron.backward")
                .frame(width: 40, height: 40)
                .font(.system(size: 35))
                .onTapGesture {
                    backClicked()
                }
            Text(title)
                .font(Font.bold(size: 24))
                .kerning(0.45)
                .foregroundColor(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    TopView(title: "My Title") {
        
    }
}
