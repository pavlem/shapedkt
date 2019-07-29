//
//  UIView+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/20/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

extension UIView {
    
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (image != nil) { return image! }
        return UIImage()
    }
}
