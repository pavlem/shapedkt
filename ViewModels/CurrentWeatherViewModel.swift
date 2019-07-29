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
    var isMetric = true
    
    // MARK: Computed
    var detailesDescription: String {
        var genDescr = ""
        if let genDescription = self.generalDescription {
            genDescr = "Today".localized + genDescription + "."
        }
        
        var temp = ""
        if let curT = self.currentT {
            temp = " " + "CurrentT".localized + curT + "."
        }
        
        var highLow = ""
        if let hightT = self.highestTemp, let lowT = self.lowestTemp {
            highLow = " " + "HighLow".localized + hightT + "," + lowT + "."
        }
        
        var sunriseSunset = ""
        if let sunR = self.sunrise, let sunS = self.sunset {
            sunriseSunset = " " + sunR + ", " + sunS + "."
        }

        return genDescr + temp + highLow + sunriseSunset
    }
    
    var countryDetails: (countryName: String?, countryFlag: String?) {
        let countryDetails = CurrentWeatherViewModel.getCountryNameAndFlag(fromCode: self.countryCode)
        return (countryDetails.countryName, countryDetails.countryFlag)
    }
    
    var currentT: String? {
        if isMetric {
            return self.tInC
        } else {
            return self.tInF
        }
    }
    
    var highestTemp: String? {
        if isMetric {
            return self.tInCMax
        } else {
            return self.tInFMax
        }
    }
    
    var lowestTemp: String? {
        if isMetric {
            return self.tInCMin
        } else {
            return self.tInFMin
        }
    }

    // MARK: - Inits
    init(weather: CurrentWeather) {
        self.coordinates = CurrentWeatherViewModel.getCordinates(lat: weather.coord?.lat, long: weather.coord?.lon)
        self.shortDescription = weather.weather?.first?.main
        self.generalDescription = weather.weather?.first?.description
        
        self.tInC = CurrentWeatherViewModel.getTemperature(tempInKelvin: weather.main?.temp, isMetric: true)
        self.tInF =  CurrentWeatherViewModel.getTemperature(tempInKelvin: weather.main?.temp, isMetric: false)
        self.tInCMax = CurrentWeatherViewModel.getTemperature(tempInKelvin: weather.main?.temp_max, isMetric: true)
        self.tInCMin = CurrentWeatherViewModel.getTemperature(tempInKelvin: weather.main?.temp_min, isMetric: true)
        self.tInFMax = CurrentWeatherViewModel.getTemperature(tempInKelvin: weather.main?.temp_max, isMetric: false)
        self.tInFMin = CurrentWeatherViewModel.getTemperature(tempInKelvin: weather.main?.temp_min, isMetric: false)
        
        self.iconUrl = CurrentWeatherViewModel.getWeatherIconURLString(weather.weather?.first?.icon)
        self.pressure = CurrentWeatherViewModel.get(pressure: weather.main?.pressure)
        self.humidity = CurrentWeatherViewModel.get(humidity: weather.main?.humidity)
        self.seaLlvPressure = CurrentWeatherViewModel.get(seaLvlPressure: weather.main?.sea_level)
        self.groundLlvPressure = CurrentWeatherViewModel.get(groundLlvPressure: weather.main?.grnd_level)
        
        self.windSpeedMetric = CurrentWeatherViewModel.getWindSpeed(weather.wind?.speed, isMetric: true)
        self.windSpeedImperial = CurrentWeatherViewModel.getWindSpeed(weather.wind?.speed, isMetric: false)
        self.windSpeedDirection = CurrentWeatherViewModel.get(windSpeedDirection: weather.wind?.deg)
        
        self.clouds = CurrentWeatherViewModel.getCloudiness(weather.clouds?.all)
        self.cityName = CurrentWeatherViewModel.get(cityName: weather.name)
        self.dateForDataRetreived = CurrentWeatherViewModel.getDateString(weather.date)
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

    static func getDateString(_ unixDate: Double?) -> String? {
        guard let unixTimestamp = unixDate else { return nil }
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    static func getTimeString(_ unixDate: Double?) -> String? {
        guard let unixTimestamp = unixDate else { return nil }
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
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
    
    // D
    static func getTemperature(tempInKelvin: Double?, isMetric: Bool) -> String? {
        guard let temp = tempInKelvin else { return nil }
        if isMetric {
            return String(CurrentWeatherViewModel.getTempInC(fromKelvin: temp))
        }
        return String(CurrentWeatherViewModel.getTempInF(fromKelvin: temp))
    }
    
    // D
    static func getTempInF(fromKelvin tempInK: Double) -> Int {
        let doubleValue = (((tempInK - 273.15) * 9/5) + 32).rounded(toPlaces: 0)
        let intValue = Int(doubleValue)
        return intValue
    }

    // D
    static func getTempInC(fromKelvin tempInK: Double) -> Int {
        let doubleValue = (tempInK - 273.15).rounded(toPlaces: 0)
        let intValue = Int(doubleValue)
        return intValue
    }

    // D
    static func getWeatherIconURLString(_ icon: String?) -> String? {
        guard let icon = icon else { return nil }
        return "http://openweathermap.org/img/wn/" + icon + "@2x.png"
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
    
    // D
    static func getWindSpeed(_ windSpeed: Double?, isMetric: Bool) -> String? {
        guard let speed = windSpeed else { return nil }
        
        if isMetric {
            return String(speed.rounded(toPlaces: 2)) + " " + "MetersPerSecond".localized
        }
        return String((speed * 2.237).rounded(toPlaces: 2)) + " " + "MilesPerHour".localized
    }

    static func get(windSpeedDirection: Double?) -> String? {
        guard let windSpeedDirection = windSpeedDirection else { return nil }
        return "windSpeedDirectionIs".localized + " " + String(windSpeedDirection)
    }
}
