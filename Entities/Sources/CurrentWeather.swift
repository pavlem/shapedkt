//
//  CurrentWeather.swift
//  Entities
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public struct CurrentWeatherCoordinates: Codable {
    public let lon: Double?
    public let lat: Double?
}

public struct CurrentWeatherWeatherData: Codable {
    public let id: Int?
    public let main: String?
    public let description: String?
    public let icon: String?
}

public struct CurrentWeatherMain: Codable {
    public let temp: Double?
    public let pressure: Double?
    public let humidity: Double?
    public let temp_min: Double?
    public let temp_max: Double?
    public let grnd_level: Double?
    public let sea_level: Double?
}

public struct CurrentWeatherWind: Codable {
    public let speed: Double?
    public let deg: Double?
    public let gust: Double?
}

public struct CurrentWeatherClouds: Codable {
    public let all: Int?
}

public struct CurrentWeatherSys: Codable {
    public let type: Int?
    public let id: Int?
    public let message: Double?
    public let country: String?
    public let sunrise: Double?
    public let sunset: Double?
}

public struct CurrentWeather: Codable {
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case date = "dt"
        case sys
        case timezone
        case id
        case name
        case cod
    }
    
    public let coord: CurrentWeatherCoordinates?
    public let weather: [CurrentWeatherWeatherData]?
    public let base: String?
    public let main: CurrentWeatherMain?
    public let visibility: Int?
    public let wind: CurrentWeatherWind?
    public let clouds: CurrentWeatherClouds?
    public let date: Double?
    public let sys: CurrentWeatherSys?
    public let timezone: Int?
    public let id: Int?
    public let name: String?
    public let cod: Int?
}
