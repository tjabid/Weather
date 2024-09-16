//
//  WeatherLocalDataSource.swift
//  Weather
//
//  Created by Abdul rahim on 11/09/2024.
//

import Foundation

protocol WeatherLocalDataSourceProtocol {
    func hasCachedItem() -> Bool
    func getCached() -> [WeatherCache]
    func getLoadedWeather(query: String, showForecast: Bool) -> Weather?
    func saveLoadedItem(item: Weather)
    func updateSavedLocation(name: String) -> Weather?
}

class WeatherLocalDataSource: WeatherLocalDataSourceProtocol {    
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private var cachedWeather: [WeatherCache]
    private var currentList: [Weather]
    
    init(cachedWeather: [WeatherCache] = [], decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
        self.decoder = decoder
        
        self.cachedWeather = cachedWeather
        self.self.currentList = []
        self.loadItem()
    }
    
    private func loadItem() {
        if let savedItemsData = UserDefaults.standard.data(forKey: "savedItem") {
            let weather: [WeatherCache] = (try? decoder.decode([WeatherCache].self, from: savedItemsData)) ?? []
            if !weather.isEmpty {
                self.cachedWeather = weather
            }
        }
    }
    
    func hasCachedItem() -> Bool {
        return !cachedWeather.isEmpty
    }
    
    func getCached() -> [WeatherCache] {
        return cachedWeather
    }
    
    func getLoadedWeather(query: String, showForecast: Bool = false) -> Weather? {
        if let old = self.currentList.first(where: { $0.name == query && $0.showForecast == showForecast }) {
            return old
        }
        return nil
    }
    
    func saveLoadedItem(item: Weather) {
        if !self.currentList.contains(where: { $0.name == item.name }) {
            self.currentList.insert(item, at: currentList.endIndex)
        }
    }
    
    func saveItem(item: Weather) {
        if !self.currentList.contains(where: { $0.name == item.name }) {
            self.currentList.insert(item, at: currentList.endIndex)
        }
        
        let newElement = WeatherMapper().parseCacheWeatherItem(item: item)
        if self.cachedWeather.firstIndex(where: { $0.name == newElement.name }) != nil {
            return
        }
        self.cachedWeather.insert(newElement, at: cachedWeather.endIndex)
        saveCachedList()
    }
    
    func saveList(items: [Weather]) {
        self.cachedWeather = WeatherMapper().parseCacheWeather(items: items)
        self.currentList = items
        saveCachedList()
    }
    
    func updateItem(item: Weather, newSaveValue: Bool) {
        let newElement = WeatherMapper().parseCacheWeatherItem(item: item)
        
        if newSaveValue {
            self.currentList.insert(item, at: currentList.endIndex)
            self.cachedWeather.insert(newElement, at: cachedWeather.endIndex)
        } else {
            if let index = self.cachedWeather.firstIndex(where: { $0.name == newElement.name }) {
                self.cachedWeather.remove(at: index)
            }
        }
        saveCachedList()
    }
    
    private func saveCachedList() {
        if let encoded = try? encoder.encode(cachedWeather) {
            UserDefaults.standard.set(encoded, forKey: "savedItem")
        }
    }
    
    func updateSavedLocation(name: String) -> Weather? {
        
        let saved = self.cachedWeather.contains(where: { $0.name == name })
        let newSavedValue = !saved
        
        if var old = self.currentList.first(where: { $0.name == name }) {
            old.savedLocation = newSavedValue
            updateItem(item: old, newSaveValue: old.savedLocation)
            return old
        }
        
        if newSavedValue {
            let newElement = WeatherCache(name: name, showForecast: false)
            self.cachedWeather.insert(newElement, at: cachedWeather.endIndex)
        } else {
            if let index = self.cachedWeather.firstIndex(where: { $0.name == name }) {
                self.cachedWeather.remove(at: index)
            }
        }
        return nil
    }
}
