//
//  WeatherRemoteDataSource.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation

typealias CurrentWeatherCompletionHandler = (Weather?, Error?) -> Void

class WeatherRemoteDataSource {
    
    private let baseUrl = "https://api.weatherapi.com/v1/"
    private let apiKey = "646b79fbc24e4733b3652139241109"
    private let decoder: JSONDecoder
    private let session: URLSession
    private let mapper: WeatherMapper
    
    init(session: URLSession = URLSession(configuration: .default), decoder: JSONDecoder = JSONDecoder(), mapper: WeatherMapper = WeatherMapper()) {
        self.session = session
        self.decoder = decoder
        self.mapper = mapper
    }
    
    private func getBaseRequest<T: Codable>(url: URL, completionHandler completion:  @escaping (_ object: T?,_ error: Error?) -> ()) {
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, ResponseError.requestFailed)
                        return
                    }
                    log(message: httpResponse)
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(T.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            print(error)
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, ResponseError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    func getCoordinatesWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: "\(baseUrl)current.json?key=\(apiKey)&q=\(coordinate.latitude),\(coordinate.longitude)&aqi=no") else { fatalError("Missing URL")
        }
        
        getBaseRequest(url: url) { (weather: EndpointResponse?, error: Error?) in
            guard let w = self.mapper.parseCurrent(response: weather) else{
                completion(nil, ResponseError.jsonParsingFailure)
                return
            }
            completion(w, error)
        }
    }
    
    func getWeatherForecast(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: "\(baseUrl)forecast.json?key=\(apiKey)&q=\(coordinate.latitude),\(coordinate.longitude)&days=10&aqi=no&alerts=no") else { fatalError("Missing URL")
        }
        
        getBaseRequest(url: url) { (weather: EndpointResponse?, error: Error?) in
            guard let w = self.mapper.parseForecast(response: weather) else{
                completion(nil, ResponseError.jsonParsingFailure)
                return
            }
            completion(w, error)
        }
    }
}

enum ResponseError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}
