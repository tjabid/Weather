//
//  SeacrhCityView.swift
//  Weather
//
//  Created by Abdul rahim on 11/09/2024.
//

import SwiftUI


struct SearchCityView: View {
    
    let viewModel: MainViewModel
    let selectionCallback: () -> Void
    
    @State private var searchText = ""
    

    var body: some View {
        let items = [
            "New York", "Los Angeles", "London", "Paris", "Dubai", "Istanbul", "Moscow", "Mumbai",
            "Toronto", "Sydney", "Berlin", "Singapore", "Hong Kong", "Chicago", "São Paulo", "Mexico City", "Bangkok", "Kuala Lumpur",
            "Rome", "Madrid", "Barcelona", "San Francisco", "Seoul", "Buenos Aires", "Jakarta", "Lagos", "Cape Town", "Beijing",
            "Rio de Janeiro", "Melbourne", "Delhi", "Cairo", "Dublin", "Stockholm", "Vienna", "Zurich", "Lisbon", "Brussels",
            "Warsaw", "Budapest", "Munich", "Prague", "Milan", "Venice", "Copenhagen", "Amsterdam", "Oslo", "Athens",
            "Edinburgh", "Helsinki", "Reykjavik", "Brisbane", "Auckland", "Manila", "Taipei", "Tehran", "Riyadh", "Bangalore",
            "Ho Chi Minh City", "Hanoi", "Tel Aviv", "Jerusalem", "Lima", "Santiago", "Johannesburg", "Montreal", "Vancouver", "Seattle",
            "Boston", "Philadelphia", "Dallas", "Houston", "Atlanta", "Miami", "Washington D.C.", "Las Vegas", "Phoenix", "San Diego",
            "Orlando", "Portland", "San Jose", "Austin", "Denver", "Detroit", "Charlotte", "Nashville", "New Orleans", "Pittsburgh",
            "Minneapolis", "St. Louis", "Kansas City", "Salt Lake City", "Columbus", "Cleveland", "Indianapolis", "Cincinnati", "Milwaukee", "Baltimore"
        ]


        var filteredItems: [String] {
            if searchText.isEmpty {
                return items
            } else {
                return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        VStack {
            TopView(title: "Search City") {
                viewModel.setSearchView(showSearchView: false)
            }
            // Search bar
            TextField("Search...", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            // List of filtered items
            List(filteredItems, id: \.self) { item in
                Text(item)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .onTapGesture {
                        viewModel.loadWeatherDataFromSearchView(query: item)
                        selectionCallback()
                    }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}

#Preview {
    SearchCityView(viewModel: MainViewModel.getDefaultValue()) {}
}
