//
//  WeatherRemoteDataSource.swift
//  Weather
//
//  Created by Abdul rahim on 04/09/2024.
//

import Foundation

typealias CurrentWeatherCompletionHandler = (WeatherResponse?, Error?) -> Void

class WeatherRemoteDataSource {
    
    private let apiKey = "f9bdec1d40c30da63dbdd46711a675f9"
    private let decoder = JSONDecoder()
    private let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
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
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric") else { fatalError("Missing URL")
        }
        
        getBaseRequest(url: url) { (weather: WeatherResponse?, error: Error?) in
            completion(weather, error)
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
