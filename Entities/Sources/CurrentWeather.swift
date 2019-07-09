//
//  CurrentWeather.swift
//  Entities
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public struct CurrentWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case name
    }
    
    public let date: Date
    public let name: String
}

//["wind": {
//    deg = 100;
//    speed = "2.6";
//    }, "id": 3470034, "sys": {
//        country = BR;
//        id = 8314;
//        message = "0.0065";
//        sunrise = 1562664802;
//        sunset = 1562703966;
//        type = 1;
//    }, "weather": <__NSArrayM 0x600003a29110>(
//    {
//    description = mist;
//    icon = 50d;
//    id = 701;
//    main = Mist;
//    }
//    )
//    , "visibility": 5000, "coord": {
//        lat = "-21.61";
//        lon = "-43.69";
//    }, "base": stations, "main": {
//        humidity = 93;
//        pressure = 1029;
//        temp = "282.15";
//        "temp_max" = "282.15";
//        "temp_min" = "282.15";
//    }, "name": Bias Fortes, "timezone": -10800, "dt": 1562665274, "clouds": {
//        all = 75;
//    }, "cod": 200]
