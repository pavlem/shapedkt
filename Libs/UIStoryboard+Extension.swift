//  UIStoryboard+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.

import Foundation
import UIKit

extension UIStoryboard {
    // MARK: - Storyboards
    static var weather: UIStoryboard { return UIStoryboard(name: "Weather", bundle: Bundle.main) }
   
    // MARK: - View controllers
    static var weatherVC: WeatherVC { return UIStoryboard.weather.instantiateViewController(withIdentifier: "WeatherVC_ID") as! WeatherVC }
   
}
