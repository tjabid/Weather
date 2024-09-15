//
//  WeatherRemoteDataSourceTests.swift
//  WeatherTests
//
//  Created by Abdul rahim on 15/09/2024.
//

import XCTest
@testable import Weather


class WeatherRemoteDataSourceTests: XCTestCase {

    var remoteDataSource: WeatherRemoteDataSource!
        var mockSession: URLSessionMock!
        var mockDecoder: JSONDecoder!
        var mockMapper: WeatherMapper!

        override func setUp() {
            super.setUp()
            mockSession = URLSessionMock()
            mockDecoder = JSONDecoder()
            mockMapper = WeatherMapper()
            remoteDataSource = WeatherRemoteDataSource(session: mockSession, decoder: mockDecoder, mapper: mockMapper)
        }

    override func tearDown() {
        remoteDataSource = nil
        mockSession = nil
        mockDecoder = nil
        mockMapper = nil
        super.tearDown()
    }
    
    func testGetCoordinatesWeatherFailure() {        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://api.weatherapi.com/v1/current.json")!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)!
        
        let expectation = self.expectation(description: "Completion handler invoked")
        var weather: Weather?
        var error: Error?
        
        mockSession.data = nil
        mockSession.response = httpResponse
        mockSession.error = ResponseError.requestFailed
        
        remoteDataSource.getCoordinatesWeather(at: "London") { result, err in
            weather = result
            error = err
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertNotNil(error)
        XCTAssertNil(weather)
    }

//    func testGetCoordinatesWeatherSuccess() {
//        let json = jsonGetCoordinatesWeatherSuccess.data(using: .utf8)!
//        
//        let httpResponse = HTTPURLResponse(url: URL(string: "https://api.weatherapi.com/v1/current.json")!,
//                                           statusCode: 200,
//                                           httpVersion: nil,
//                                           headerFields: nil)!
//        
//        let expectation = self.expectation(description: "Completion handler invoked")
//        var weather: Weather?
//        var error: Error?
//        
//        mockSession.data = json
//        mockSession.response = httpResponse
//        mockSession.error = nil
//        
//        remoteDataSource.getCoordinatesWeather(at: "London") { result, err in
//            weather = result
//            error = err
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 1.0, handler: nil)
//        
//        XCTAssertNil(error)
//        XCTAssertNotNil(weather)
//        XCTAssertEqual(weather?.name, "London")
//        XCTAssertEqual(weather?.tempC, "20.0")
//        XCTAssertEqual(weather?.description, "Partly cloudy")
//    }
    
    func testGetWeatherForecastFailure() {

        let expectation = self.expectation(description: "Completion handler invoked")
        var weather: Weather?
        var error: Error?

        mockSession.data = nil
        mockSession.error = ResponseError.requestFailed

        remoteDataSource.getWeatherForecast(at: "London", showForecast: true) { result, err in
            weather = result
            error = err
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertNotNil(error)
        XCTAssertNil(weather)
    }

//    func testGetWeatherForecastSuccess() {
//        let json = jsonGetWeatherForecastSuccess.data(using: .utf8)!
//
//        let expectation = self.expectation(description: "Completion handler invoked")
//        var weather: Weather?
//        var error: Error?
//
//        mockSession.data = json
//        mockSession.error = nil
//
//        remoteDataSource.getWeatherForecast(at: "London", showForecast: true) { result, err in
//            weather = result
//            error = err
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1.0, handler: nil)
//
//        XCTAssertNil(error)
//        XCTAssertNotNil(weather)
//        XCTAssertEqual(weather?.forecast.count, 1)
//        XCTAssertEqual(weather?.forecast.first?.description, "Partly cloudy")
//        XCTAssertEqual(weather?.forecast.first?.maxtempC, "21.0")
//    }
}

// URLSession mock
class URLSessionMock: URLSession {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock(data: data, response: response, error: error, completionHandler: completionHandler)
    }
}

// URLSessionDataTask mock
class URLSessionDataTaskMock: URLSessionDataTask {
    private let data: Data?
    private let responseMock: HTTPURLResponse?
    private let errorMock: Error?
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void

    init(data: Data?, response: HTTPURLResponse?, error: Error?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.data = data
        self.responseMock = response
        self.errorMock = error
        self.completionHandler = completionHandler
    }

    override func resume() {
        completionHandler(data, response, errorMock)
    }
}

let jsonGetWeatherForecastSuccess = """
        {
            "location": {
                "name": "London",
                "region": "",
                "country": "United Kingdom",
                "lat": 51.51,
                "lon": -0.13,
                "tz_id": "Europe/London",
                "localtime_epoch": 1630554600,
                "localtime": "2021-09-02 10:30"
            },
            "forecast": {
                "forecastday": [
                    {
                        "date": "2021-09-02",
                        "date_epoch": 1630554600,
                        "day": {
                            "maxtemp_c": 21.0,
                            "maxtemp_f": 69.8,
                            "mintemp_c": 15.0,
                            "mintemp_f": 59.0,
                            "avgtemp_c": 18.0,
                            "avgtemp_f": 64.4,
                            "maxwind_mph": 12.0,
                            "maxwind_kph": 19.3,
                            "totalprecip_mm": 0.0,
                            "totalprecip_in": 0.0,
                            "totalsnow_cm": 0.0,
                            "avgvis_km": 10.0,
                            "avgvis_miles": 6.2,
                            "avghumidity": 60,
                            "daily_will_it_rain": 0,
                            "daily_chance_of_rain": 0,
                            "daily_will_it_snow": 0,
                            "daily_chance_of_snow": 0,
                            "condition": {
                                "text": "Partly cloudy",
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                                "code": 1003
                            },
                            "uv": 5.0
                        }
                    }
                ]
            },
            "current": {
                "last_updated_epoch": 1630554600,
                "last_updated": "2021-09-02 10:30",
                "temp_c": 20.0,
                "temp_f": 68.0,
                "is_day": 1,
                "condition": {
                    "text": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                    "code": 1003
                },
                "wind_mph": 10.0,
                "wind_kph": 16.1,
                "wind_degree": 200,
                "wind_dir": "SSW",
                "pressure_mb": 1012,
                "pressure_in": 29.9,
                "precip_mm": 0.0,
                "precip_in": 0.0,
                "humidity": 60,
                "cloud": 25,
                "feelslike_c": 18.0,
                "feelslike_f": 64.4,
                "vis_km": 10.0,
                "uv": 5.0,
                "gust_mph": 12.0,
                "gust_kph": 19.3
            }
        }
        """

let jsonGetCoordinatesWeatherSuccess = """
        {
            "location": {
                "name": "London",
                "region": "",
                "country": "United Kingdom",
                "lat": 51.51,
                "lon": -0.13,
                "tz_id": "Europe/London",
                "localtime_epoch": 1630554600,
                "localtime": "2021-09-02 10:30"
            },
            "current": {
                "last_updated_epoch": 1630554600,
                "last_updated": "2021-09-02 10:30",
                "temp_c": 20.0,
                "temp_f": 68.0,
                "is_day": 1,
                "condition": {
                    "text": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                    "code": 1003
                },
                "wind_mph": 10.0,
                "wind_kph": 16.1,
                "wind_degree": 200,
                "wind_dir": "SSW",
                "pressure_mb": 1012,
                "pressure_in": 29.9,
                "precip_mm": 0.0,
                "precip_in": 0.0,
                "humidity": 60,
                "cloud": 25,
                "feelslike_c": 18.0,
                "feelslike_f": 64.4,
                "vis_km": 10.0,
                "uv": 5.0,
                "gust_mph": 12.0,
                "gust_kph": 19.3
            }
        }
        """
