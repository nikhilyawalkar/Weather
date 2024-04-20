//
//  NetworkManager.swift
//  Weather
//
//  Created by Nikhil yawalkar on 20/04/24.
//

import Foundation

struct NetworkManager {
    func getTodaysWeatherForecast() async throws -> CityWeatherResponse {
        let endpoint = "https://api.weatherapi.com/v1/forecast.json?key=bfb5156e31784e199b852937242004&q=13.006731,77.762726&days=10&aqi=yes&alerts=no"
        
        guard let url = URL(string: endpoint) else { throw WAError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw WAError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(CityWeatherResponse.self, from: data)
        } catch {
            print(String(describing: error))
            throw WAError.invalidData
        }
    }
}

enum WAError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
