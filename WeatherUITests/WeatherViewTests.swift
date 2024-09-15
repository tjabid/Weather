//
//  WeatherViewTests.swift
//  WeatherUITests
//
//  Created by Abdul rahim on 14/09/2024.
//

import XCTest

final class WeatherViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        XCUIApplication().terminate()
    }
    
    func testTitleIsDisplayed() throws {
        let app = XCUIApplication()
        let titleLabel = app.staticTexts["Weather"]
        
        // Check if the labels exists
        XCTAssertTrue(titleLabel.exists)
    }
    
    func testSearchIsDisplayed() throws {
        let app = XCUIApplication()
        let searchLabel = app.staticTexts["Search city"]
        
        // Check if the labels exists
        XCTAssertTrue(searchLabel.exists)
    }
    
    func testForecastIsDisplayed() throws {
        let app = XCUIApplication()
        let forecast = app.staticTexts["10-DAY FORECAST"]
        
        // Check if the images exists
        XCTAssertTrue(forecast.exists)
    }
    
    func testSearchCityTapGesture() throws {
        let app = XCUIApplication()
//        let tapView = app.otherElements["WeatherCellView"]
        let searchLable = app.staticTexts["Search city"]
        
        let tempLabel = app.staticTexts["Search City"]
        let heartImage = app.images["heart.fill"]
        
        // Simulate tap gesture
        searchLable.tap()
        
        // Verify state after tap
        XCTAssertTrue(tempLabel.exists)
        XCTAssertFalse(heartImage.exists)
    }
}

