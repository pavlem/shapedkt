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
    
    func testCoordinateConversion() {
//        let coordinate1 = Coordinates(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: -9.960892521935094, longitude: -71.81640625000004))
//        let coordinateFromStringInit1 = Coordinates(latitude: "-9.960892521935094", longitude: "-71.81640625000004")
//        XCTAssert((coordinate1.latitude, coordinate1.longitude) == (coordinateFromStringInit1.latitude, coordinateFromStringInit1.longitude), "🍊🍊, testCoordinateConversion not ok")
//
//        let coordinate2 = Coordinates(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: 42.13573230472247, longitude: 11.810691528326089))
//        let coordinateFromStringInit2 = Coordinates(latitude: "42.13573230472247", longitude: "11.810691528326089")
//        XCTAssert((coordinate2.latitude, coordinate2.longitude) == (coordinateFromStringInit2.latitude, coordinateFromStringInit2.longitude), "🍊🍊, testCoordinateConversion not ok")
    }
}

// MARK: - CurrentWeatherViewModel
extension forecastTests {
    func testGetTemperature() {
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 300.0, isMetric: true) == "27", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 300.0, isMetric: false) == "80", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 400.0, isMetric: true) == "127", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 400.0, isMetric: false) == "260", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 200.0, isMetric: true) == "-73", "🍊🍊, testGetTemperature not ok")
        XCTAssert(CurrentWeatherViewModel.getTemperature(tempInKelvin: 200.0, isMetric: false) == "-100", "🍊🍊, testGetTemperature not ok")
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
}
