//
//  forecastTests.swift
//  forecastTests
//
//  Created by Pavle Mijatovic on 7/9/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import XCTest
@testable import forecast
import MapKit

class forecastTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - CurrentWeatherViewModel
extension forecastTests {
    func testGetTemperature() {
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 300.0, isMetric: true) == "27 º", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 300.0, isMetric: false) == "80 ºF", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 400.0, isMetric: true) == "127 º", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 400.0, isMetric: false) == "260 ºF", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 200.0, isMetric: true) == "-73 º", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 200.0, isMetric: false) == "-100 ºF", "🍊🍊, testGetTemperature not ok")
    }
    
    func testGetTempInF() {
        XCTAssert(CurrentWeatherViewModel.getTempInF(fromKelvin: 300.0) == 80, "🍊🍊, testGetTempInF not ok")
        XCTAssert(CurrentWeatherViewModel.getTempInF(fromKelvin: 400.0) == 260, "🍊🍊, testGetTempInF not ok")
        XCTAssert(CurrentWeatherViewModel.getTempInF(fromKelvin: 200.0) == -100, "🍊🍊, testGetTempInF not ok")
    }
    
    func testGetTempInC() {
        XCTAssert(CurrentWeatherViewModel.getTempInC(fromKelvin: 300.0) == 27, "🍊🍊, testGetTempInC not ok")
        XCTAssert(CurrentWeatherViewModel.getTempInC(fromKelvin: 400.0) == 127, "🍊🍊, testGetTempInC not ok")
        XCTAssert(CurrentWeatherViewModel.getTempInC(fromKelvin: 200.0) == -73, "🍊🍊, testGetTempInC not ok")
    }
    
    func testGetWeatherIconURLString() {
        XCTAssert(CurrentWeatherViewModel.getWeatherIconURLString("1a") == "http://openweathermap.org/img/wn/1a@2x.png", "🍊🍊, getWeatherIconURLString not ok")
        
        XCTAssert(CurrentWeatherViewModel.getWeatherIconURLString("5d") == "http://openweathermap.org/img/wn/5d@2x.png", "🍊🍊, getWeatherIconURLString not ok")
        XCTAssert(CurrentWeatherViewModel.getWeatherIconURLString(nil) == nil, "🍊🍊, getWeatherIconURLString not ok")
    }
    
    func testGetWindSpeed() {
        let sm1 = CurrentWeatherViewModel.getWindSpeed(1.5, isMetric: true)
        let sm2 = CurrentWeatherViewModel.getWindSpeed(100.0, isMetric: true)
        let sm3 = CurrentWeatherViewModel.getWindSpeed(30, isMetric: true)
        let si1 = CurrentWeatherViewModel.getWindSpeed(1.5, isMetric: false)
        let si2 = CurrentWeatherViewModel.getWindSpeed(100.0, isMetric: false)
        let si3 = CurrentWeatherViewModel.getWindSpeed(30, isMetric: false)
        
        XCTAssert(sm1 == "1.5 m/s", "🍊🍊, testGetWindSpeed not ok")
        XCTAssert(sm2 == "100.0 m/s", "🍊🍊, testGetWindSpeed not ok")
        XCTAssert(sm3 == "30.0 m/s", "🍊🍊, testGetWindSpeed not ok")
        XCTAssert(si1 == "3.36 MPH", "🍊🍊, testGetWindSpeed not ok")
        XCTAssert(si2 == "223.7 MPH", "🍊🍊, testGetWindSpeed not ok")
        XCTAssert(si3 == "67.11 MPH", "🍊🍊, testGetWindSpeed not ok")
    }
    
    func testWeatherVM() {
        MOCHelper.fetchWeather { (isFetched, currentWeather) in
            guard let weather = currentWeather else { return }
            let weatherVM = CurrentWeatherViewModel(weather: weather)

            // stored properties
            XCTAssert(weatherVM.coordinates == "Selected Latitute And Longitude Are: -15.79, -48.09", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.shortDescription == "Clear", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.generalDescription == "Clear Sky", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.iconUrl == "http://openweathermap.org/img/wn/01n@2x.png", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.tInC == "13 º", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.tInCMax == "15 º", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.tInCMin == "11 º", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.tInF == "55 ºF", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.tInFMax == "59 ºF", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.tInFMin == "52 ºF", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.pressure == "Pressure: 1020.0 hPa", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.humidity == "Humidity: 82.0 %", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.windSpeedMetric == "1.0 m/s", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.windSpeedImperial == "2.24 MPH", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.windSpeedDirection == "Wind Speed Direction: 270.0 º", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.clouds == "Cloudiness: None", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.cityName == "City Name: Brasilia", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.sunrise == "Sunrise: 11:36", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.sunset == "Sunset: 23:00", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.timeZone == "Timezone: -03:00 From GMT", "🍊🍊, testWeatherVM not ok")

            // calculated properties
            XCTAssert(weatherVM.detailesDescription == "Today is Clear Sky. Current temp: 13 º. High and Low are: 15 º, 11 º. Sunrise: 11:36h and Sunset: 23:00h.", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.countryDetails.countryName == "Brazil", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.countryDetails.countryFlag == "🇧🇷", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.lowestTempD == "Lowest temp: 11 º", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.highestTempD == "Highest temp: 15 º", "🍊🍊, testWeatherVM not ok")
            XCTAssert(weatherVM.currentTD == "Current temp: 13 º", "🍊🍊, testWeatherVM not ok")
        }
    }
}
