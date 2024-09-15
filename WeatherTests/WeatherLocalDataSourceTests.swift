//
//  WeatherLocalDataSourceTests.swift
//  WeatherTests
//
//  Created by Abdul rahim on 14/09/2024.
//

import XCTest
@testable import Weather

class WeatherLocalDataSourceTests: XCTestCase {

    var localDataSource: WeatherLocalDataSource!
    var mockWeatherCache: [WeatherCache]!
    var mockWeatherList: [Weather]!

    override func setUpWithError() throws {
        super.setUp()
        // Initialize with empty cache and weather list for each test
        mockWeatherCache = []
        mockWeatherList = []
        localDataSource = WeatherLocalDataSource(cachedWeather: mockWeatherCache)
    }

    override func tearDownWithError() throws {
        localDataSource = nil
        mockWeatherCache = nil
        mockWeatherList = nil
        super.tearDown()
    }

    func testHasCachedItem_NoCache() throws {
        localDataSource.saveList(items: [])
        
        XCTAssertFalse(localDataSource.hasCachedItem())
    }

    func testHasCachedItem_WithCache() throws {
        mockWeatherCache.append(WeatherCache(name: "Test Location", showForecast: false))
        localDataSource = WeatherLocalDataSource(cachedWeather: mockWeatherCache)
        
        XCTAssertTrue(localDataSource.hasCachedItem())
    }

    func testSaveLoadedItem() throws {
        let weather = Weather.getDefaultValue()
        
        localDataSource.saveLoadedItem(item: weather)
        let cachedWeather = localDataSource.getCached()
        
        XCTAssertTrue(cachedWeather.contains(where: { $0.name == weather.name }))
    }

    func testGetLoadedWeather() throws {
        let weather = Weather.getDefaultValue()
        localDataSource.saveLoadedItem(item: weather)
        
        let result = localDataSource.getLoadedWeather(query: weather.name, showForecast: weather.showForecast)
        
        XCTAssertEqual(result?.name, weather.name)
    }

    func testSaveItem() throws {
        let weather = Weather.getDefaultValue()
        localDataSource.saveItem(item: weather)
        
        let cachedWeather = localDataSource.getCached()
        
        XCTAssertTrue(cachedWeather.contains(where: { $0.name == weather.name }))
    }

    func testUpdateItem_Save() throws {
        let weather = Weather.getDefaultValue()
        localDataSource.saveItem(item: weather)
        
        let updatedWeather = Weather(name: weather.name, country: weather.country, coordinate: weather.coordinate, tempC: weather.tempC, feelslikeC: weather.feelslikeC, windKph: weather.windKph, windDegree: weather.windDegree, windDirection: weather.windDirection, humidity: weather.humidity, cloud: weather.cloud, visibilityKM: weather.visibilityKM, uv: weather.uv, description: weather.description, lastUpdated: weather.lastUpdated, lastUpdatedEpoch: weather.lastUpdatedEpoch, forecast: weather.forecast, showForecast: true, savedLocation: true)
        localDataSource.updateItem(item: updatedWeather, newSaveValue: updatedWeather.savedLocation)
        
        let cachedWeather = localDataSource.getCached()
        
        XCTAssertTrue(cachedWeather.contains(where: { $0.name == updatedWeather.name }))
    }

    func testUpdateSavedLocation() throws {
        let weather = Weather.getDefaultValue()
        localDataSource.saveItem(item: weather)
        
        let updatedWeather = localDataSource.updateSavedLocation(name: weather.name)
        
        XCTAssertNotNil(updatedWeather)
        XCTAssertFalse(updatedWeather?.savedLocation ?? false)
    }

    func testUpdateSavedLocation_Removal() throws {
        let weather = Weather.getDefaultValue()
        
        localDataSource.saveItem(item: weather)
        _ = localDataSource.updateSavedLocation(name: weather.name)
        
        let updatedWeather = localDataSource.updateSavedLocation(name: weather.name)
        XCTAssertNotNil(updatedWeather)
    }
}

