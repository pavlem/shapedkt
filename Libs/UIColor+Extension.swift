//  UIColor+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let redPart: CGFloat = CGFloat(red) / 255
        let greenPart: CGFloat = CGFloat(green) / 255
        let bluePart: CGFloat = CGFloat(blue) / 255
        
        self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
    }
}

extension UIColor {
    static var itemListEmptyBasket: UIColor { return UIColor(rgbColorCodeRed: 242, green: 242, blue: 242, alpha: 1)}
    static var sagBackground: UIColor { return UIColor(rgbColorCodeRed: 254, green: 212, blue: 1, alpha: 1)}
    static var sunflowerYellow: UIColor {return UIColor(rgbColorCodeRed: 255, green: 212, blue: 0, alpha: 1)}
    static var yellowOrange: UIColor {return UIColor(rgbColorCodeRed: 248, green: 176, blue: 0, alpha: 1)}
    static var grassGreen: UIColor {return UIColor(rgbColorCodeRed: 66, green: 175, blue: 95, alpha: 1)}
    static var tameYellow: UIColor {return UIColor(hex: "fad85b")}
    
    enum SGAlert {
        static var negative: UIColor {return UIColor(hex: "af4242")}
        static var positive: UIColor {return UIColor(hex: "42af5f")}
    }
}
