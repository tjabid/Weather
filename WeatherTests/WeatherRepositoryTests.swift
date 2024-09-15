//
//  WeatherRepositoryTests.swift
//  WeatherTests
//
//  Created by Abdul rahim on 14/09/2024.
//

import XCTest
@testable import Weather


class WeatherRepositoryTests: XCTestCase {

    var repository: WeatherRepository!
    var mockRemoteDataSource: MockWeatherRemoteDataSource!
    var mockLocalDataSource: MockWeatherLocalDataSource!
    
    override func setUp() {
        super.setUp()
        mockRemoteDataSource = MockWeatherRemoteDataSource()
        mockLocalDataSource = MockWeatherLocalDataSource()
        repository = WeatherRepository(remoteDataSource: mockRemoteDataSource, localDataSource: mockLocalDataSource)
    }

    override func tearDown() {
        mockRemoteDataSource = nil
        mockLocalDataSource = nil
        repository = nil
        super.tearDown()
    }
    
    func testHasCachedItemReturnsTrue() {
        mockLocalDataSource.hasCachedItemReturnValue = true
        XCTAssertTrue(repository.hasCachedItem())
    }
    
    func testHasCachedItemReturnsFalse() {
        mockLocalDataSource.hasCachedItemReturnValue = false
        XCTAssertFalse(repository.hasCachedItem())
    }
    
    func testGetWeatherForCachedItemsReturnsWeatherFromLocalSource() {
        let cachedWeather = WeatherCache(name: "Location Name", showForecast: false)
        mockLocalDataSource.cachedItems = [cachedWeather]
        
        let weatherFromRemote = Weather.getDefaultValue()
        mockRemoteDataSource.weatherToReturn = weatherFromRemote
        
        let expectation = self.expectation(description: "GetWeatherForCachedItems")
        
        repository.getWeatherForCachedItems { (weather, error) in
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather?.name, weatherFromRemote.name)
            XCTAssertEqual(weather?.showForecast, weatherFromRemote.showForecast)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetCoordinatesWeatherReturnsWeatherFromRemoteSource() {
        let weatherFromRemote = Weather.getDefaultValue()
        mockRemoteDataSource.weatherToReturn = weatherFromRemote
        
        let expectation = self.expectation(description: "GetCoordinatesWeather")
        
        repository.getCoordinatesWeather(at: "Location Name") { (weather, error) in
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather?.name, weatherFromRemote.name)
            XCTAssertEqual(weather?.showForecast, weatherFromRemote.showForecast)
            XCTAssertEqual(weather?.id, weatherFromRemote.id)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetCoordinatesWeatherReturnsErrorFromRemoteSource() {
        mockRemoteDataSource.shouldReturnError = true
        
        let expectation = self.expectation(description: "GetCoordinatesWeatherError")
        
        repository.getCoordinatesWeather(at: "Location Name") { (weather, error) in
            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetWeatherForecastReturnsCachedWeather() {
        let loadedWeather = Weather.getDefaultValue()
        mockLocalDataSource.loadedWeather = [loadedWeather]
        
        let expectation = self.expectation(description: "GetWeatherForecast")
        
        repository.getWeatherForecast(at: "Location Name", showForecast: true) { (weather, error) in
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather?.name, loadedWeather.name)
            XCTAssertEqual(weather?.showForecast, loadedWeather.showForecast)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUpdateSavedLocation() {
        let loadedWeather = Weather.getDefaultValue()
        mockLocalDataSource.loadedWeather = [loadedWeather]
        
        let updatedWeather = repository.updateSavedLocation(name: "Location Name")
        
        XCTAssertNotNil(updatedWeather)
        XCTAssertEqual(updatedWeather?.name, "Location Name")
        XCTAssertFalse(updatedWeather?.savedLocation ?? false)
    }
    
    func testUpdateSavedLocationNil() {
        mockLocalDataSource.cachedItems = []
        
        let updatedWeather = repository.updateSavedLocation(name: "Location Name")
        
        XCTAssertNil(updatedWeather)
    }
}

// Mock for WeatherRemoteDataSourceProtocol
class MockWeatherRemoteDataSource: WeatherRemoteDataSourceProtocol {
    var shouldReturnError = false
    var weatherToReturn: Weather?
    
    func getCoordinatesWeather(at query: String, completionHandler: @escaping (Weather?, Error?) -> Void) {
        if shouldReturnError {
            completionHandler(nil, NSError(domain: "Error", code: 1, userInfo: nil))
        } else {
            completionHandler(weatherToReturn, nil)
        }
    }
    
    func getWeatherForecast(at query: String, showForecast: Bool, completionHandler: @escaping (Weather?, Error?) -> Void) {
        if shouldReturnError {
            completionHandler(nil, NSError(domain: "Error", code: 1, userInfo: nil))
        } else {
            completionHandler(weatherToReturn, nil)
        }
    }
}

// Mock for WeatherLocalDataSourceProtocol
class MockWeatherLocalDataSource: WeatherLocalDataSourceProtocol {
    
    var hasCachedItemReturnValue = false
    var cachedItems: [WeatherCache] = []
    var loadedWeather: [Weather] = []
    var savedItem: Weather?

    func hasCachedItem() -> Bool {
        return hasCachedItemReturnValue
    }

    func getCached() -> [WeatherCache] {
        return cachedItems
    }

    func getLoadedWeather(query: String, showForecast: Bool) -> Weather? {
        return loadedWeather.first(where: { $0.name == query })
    }

    func saveLoadedItem(item: Weather) {
        savedItem = item
    }

    func updateSavedLocation(name: String) -> Weather? {
        return loadedWeather.first(where: { $0.name == name })
    }
}
