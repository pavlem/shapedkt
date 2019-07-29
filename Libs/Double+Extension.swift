//
//  Double+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/29/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
