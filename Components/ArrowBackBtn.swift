//
//  ArrowBackBtn.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/19/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class ArrowBackBtn: UIButton {
    override func draw(_ rect: CGRect) {
        let viewArr = ArrowBackBtnView(frame: CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height))
        viewArr.backgroundColor = self.backgroundColor
        setImage(viewArr.imageFromView(), for: .normal)
        layer.cornerRadius = viewArr.frame.size.width / 2
        layer.masksToBounds = true
    }
}

extension UIView {
    func imageFromView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
