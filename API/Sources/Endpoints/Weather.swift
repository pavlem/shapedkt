//
//  Weather.swift
//  API
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Entities
import Client
import MapKit

extension CurrentWeather {
    public static func getCurrent(for query: String) -> Request<CurrentWeather, APIError> {
        return Request(
            url: URL(string: "weather")!,
            method: .get,
            parameters: [QueryParameters([URLQueryItem(name: "q", value: query)])],
            resource: decodeResource(CurrentWeather.self),
            error: APIError.init,
            needsAuthorization: true
        )
    }
    
    public static func getCurrent(forLatitude latitude: String, longitude: String) -> Request<CurrentWeather, APIError> {
        return Request(
            url: URL(string: "weather")!,
            method: .get,
            parameters: [QueryParameters([URLQueryItem(name: "lat", value: latitude), URLQueryItem(name: "lon", value: longitude)])],
            resource: decodeResource(CurrentWeather.self),
            error: APIError.init,
            needsAuthorization: true
        )
    }
    
    public static func getCurrentWeather(forCoordinates coordinates: Coordinates) -> Request<CurrentWeather, APIError> {
        
        return Request(
            url: URL(string: "weather")!,
            method: .get,
            parameters: [QueryParameters([URLQueryItem(name: "lat", value: coordinates.latitude!), URLQueryItem(name: "lon", value: coordinates.longitude!)])],
            resource: decodeResource(CurrentWeather.self),
            error: APIError.init,
            needsAuthorization: true
        )
    }
}

public struct Coordinates {
    
    public let latitude: String?
    public let longitude: String?
    
    public init(clLocationCoordinate2D: CLLocationCoordinate2D) {
        latitude = String(clLocationCoordinate2D.latitude)
        longitude = String(clLocationCoordinate2D.longitude)
    }
    
    public init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
