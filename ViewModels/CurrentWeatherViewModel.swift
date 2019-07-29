//
//  CurrentWeatherViewModel.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/9/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit
import Entities

struct CurrentWeatherViewModel {
    
    // MARK: - Properties
    let coordinates: String?
    let shortDescription: String?
    let generalDescription: String?
    let iconUrl: String?
    var tInC: String?
    var tInCMax: String?
    var tInCMin: String?
    var tInF: String?
    var tInFMax: String?
    var tInFMin: String?
    let pressure: String?
    let humidity: String?
    let seaLlvPressure: String?
    let groundLlvPressure: String?
    let windSpeedMetric: String?
    let windSpeedImperial: String?
    let windSpeedDirection: String?
    let clouds: String?
    let cityName: String?
    let dateForDataRetreived: String?
    let sunrise: String?
    let sunset: String?
    let countryCode: String?
    let timeZone: String?
    
    // MARK: Computed
    var detailesDescription: String {
        let d = "today" + self.generalDescription! //+ "CurrentT" + temp + "highAndLowT" + hightT + lowTemp + "sunriseSunset" + sunrise + sunset
        let temp = "currentT" + self.tInC!
        let highLowT = "highAndLowT" + self.tInCMax! + self.tInCMin!
        let sunriseSunset = "sunriseSunset" + self.sunrise! + self.sunset!
        
        return d + temp + highLowT + sunriseSunset
    }
    
    var countryDetails: (countryName: String?, countryFlag: String?) {
        let countryDetails = CurrentWeatherViewModel.getCountryNameAndFlag(fromCode: self.countryCode)
        return (countryDetails.countryName, countryDetails.countryFlag)
    }
   
    // MARK: - Inits
    init(weather: CurrentWeather) {
        self.coordinates = CurrentWeatherViewModel.getCordinates(lat: weather.coord?.lat, long: weather.coord?.lon)
        self.shortDescription = weather.weather?.first?.main
        self.generalDescription = weather.weather?.first?.description
        self.tInC = CurrentWeatherViewModel.getTemperature(tInK: weather.main?.temp, isMetric: true)
        self.tInF =  CurrentWeatherViewModel.getTemperature(tInK: weather.main?.temp, isMetric: false)
        self.tInCMax = CurrentWeatherViewModel.getTemperature(tInK: weather.main?.temp, isMetric: true)
        self.tInCMin = CurrentWeatherViewModel.getTemperature(tInK: weather.main?.temp, isMetric: true)
        self.tInFMax = CurrentWeatherViewModel.getTemperature(tInK: weather.main?.temp, isMetric: false)
        self.tInFMin = CurrentWeatherViewModel.getTemperature(tInK: weather.main?.temp, isMetric: false)
        self.iconUrl = CurrentWeatherViewModel.getWeatherIcon(weather.weather?.first?.icon)
        self.pressure = CurrentWeatherViewModel.get(pressure: weather.main?.pressure)
        self.humidity = CurrentWeatherViewModel.get(humidity: weather.main?.humidity)
        self.seaLlvPressure = CurrentWeatherViewModel.get(seaLvlPressure: weather.main?.sea_level)
        self.groundLlvPressure = CurrentWeatherViewModel.get(groundLlvPressure: weather.main?.grnd_level)
        self.windSpeedMetric = CurrentWeatherViewModel.getWindSpeed(weather.wind?.speed, isMetric: true)
        self.windSpeedImperial = CurrentWeatherViewModel.getWindSpeed(weather.wind?.speed, isMetric: false)
        self.windSpeedDirection = CurrentWeatherViewModel.get(windSpeedDirection: weather.wind?.deg)
        self.clouds = CurrentWeatherViewModel.getCloudiness(weather.clouds?.all)
        self.cityName = CurrentWeatherViewModel.get(cityName: weather.name)
        self.dateForDataRetreived = CurrentWeatherViewModel.getTimeString(weather.date)
        self.sunset = CurrentWeatherViewModel.getSunset(weather.sys?.sunset)
        self.sunrise = CurrentWeatherViewModel.getSunrise(weather.sys?.sunrise)
        self.timeZone = CurrentWeatherViewModel.getTimeZoneOffset(offestInSec: weather.timezone)
        self.countryCode = weather.sys?.country
    }
}

// MARK: - Helper
extension CurrentWeatherViewModel {
    
    static func getCountryNameAndFlag(fromCode countryCode: String?) -> (countryName: String?, countryFlag: String?) {
        guard let countryCode = countryCode else { return (nil, nil) }
        if let countryCode = CountryCodes.with(countryLabel: countryCode) {
            return (countryCode.country, countryCode.flag)
        }
        return (nil, nil)
    }
    
    static func getTimeZoneOffset(offestInSec: Int?) -> String? {
        guard let offset = offestInSec else { return nil }
        let hours = offset/3600
        let minutes = abs(offset/60) % 60
        return String(format: "%+.2d:%.2d", hours, minutes)
    }

    static func getTimeString(_ unixDate: Double?) -> String? {
        guard let unixTimestamp = unixDate else { return nil }
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    static func getSunset(_ unixDate: Double?) -> String? {
        guard let str = getTimeString(unixDate) else { return nil }
        return "Sunset".localized + " " + str
    }
    
    static func getSunrise(_ unixDate: Double?) -> String? {
        guard let str = getTimeString(unixDate) else { return nil }
        return "Sunrise".localized + " " + str
    }
    
    static func get(cityName: String?) -> String? {
        guard let cityName = cityName else { return nil }
        return "cityName".localized + " " + cityName
    }

    static func getCloudiness(_ cloudiness: Int?) -> String? {
        guard let cloudiness = cloudiness else { return nil }
        return "cloudiness".localized + " " + (cloudiness == 1 ? "complete".localized : "none".localized)
    }
    
    static func getCordinates(lat: Double?, long: Double?) -> String? {
        guard let latitude = lat else { return nil }
        guard let longitude = long else { return nil }
        return "LatAndLongAre".localized + " " + String(latitude) + ", " + String(longitude)
    }
    
    static func getTemperature(tInK: Double?, isMetric: Bool) -> String? {
        if isMetric {
            return "M"
        }
        return "I"
    }
    
    static func getWeatherIcon(_ icon: String?) -> String? {
        guard let icon = icon else { return nil }
        return "http" + icon
    }
    
    static func get(pressure: Double?) -> String? {
        guard let pressure = pressure else { return nil }
        return "pressureIs".localized + " " + String(pressure)
    }
    
    static func get(humidity: Double?) -> String? {
        guard let humidity = humidity else { return nil }
        return "humidityIs".localized + " " + String(humidity)
    }
    
    static func get(seaLvlPressure: Double?) -> String? {
        guard let seaLvlPressure = seaLvlPressure else { return nil }
        return "seaLvlPressureIs".localized + " " + String(seaLvlPressure)
    }
    
    static func get(groundLlvPressure: Double?) -> String? {
        guard let groundLlvPressure = groundLlvPressure else { return nil }
        return "groundLlvPressureIs".localized + " " + String(groundLlvPressure)
    }
    
    static func getWindSpeed(_ windSpeed: Double?, isMetric: Bool) -> String? {
        if isMetric {
            return "M"
        }
        return "I"
    }
    
    static func get(windSpeedDirection: Double?) -> String? {
        guard let windSpeedDirection = windSpeedDirection else { return nil }
        return "windSpeedDirectionIs".localized + " " + String(windSpeedDirection)
    }
}
