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
    let name: String?
    
    // MARK: - Inits
    init(weather: CurrentWeather) {
        name = "SelectedPlaceIs".localized + " " + (CurrentWeatherViewModel.getPlaceName(name: weather.name))
    }
 
    // MARK: - Helper
    static func getPlaceName(name: String?) -> String {
        guard let nameLocal = name else { return "Undefined".localized }
        guard nameLocal != "" else { return "Undefined".localized}
        return nameLocal
    }
}
