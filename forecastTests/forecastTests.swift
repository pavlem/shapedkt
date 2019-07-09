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
        let coordinate1 = Coordinates(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: -9.960892521935094, longitude: -71.81640625000004))
        let coordinateFromStringInit1 = Coordinates(latitude: "-9.960892521935094", longitude: "-71.81640625000004")
        XCTAssert((coordinate1.latitude, coordinate1.longitude) == (coordinateFromStringInit1.latitude, coordinateFromStringInit1.longitude), "🍊🍊, testCoordinateConversion not ok")
        
        let coordinate2 = Coordinates(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: 42.13573230472247, longitude: 11.810691528326089))
        let coordinateFromStringInit2 = Coordinates(latitude: "42.13573230472247", longitude: "11.810691528326089")
        XCTAssert((coordinate2.latitude, coordinate2.longitude) == (coordinateFromStringInit2.latitude, coordinateFromStringInit2.longitude), "🍊🍊, testCoordinateConversion not ok")
    }
}
