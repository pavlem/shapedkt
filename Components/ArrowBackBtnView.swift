//
//  ArrowBackBtnView.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/19/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class ArrowBackBtnView: UIView {
    
    var strokeColor: UIColor? = .black
    
    override func draw(_ rect: CGRect) {
        let padding = CGFloat(rect.size.width * 0.1)
        let arrow = UIBezierPath()
        arrow.addArrow(start: CGPoint(x: rect.size.width - padding, y: rect.size.height / 2), end: CGPoint(x: 0 + padding, y: rect.size.height / 2), pointerLineLength: rect.size.width / 3, arrowAngle: CGFloat(Double.pi / 4))
        let arrowLayer = CAShapeLayer()
        arrowLayer.strokeColor = strokeColor?.cgColor
        arrowLayer.lineWidth = 3
        arrowLayer.path = arrow.cgPath
        arrowLayer.fillColor = UIColor.clear.cgColor
        arrowLayer.lineJoin = CAShapeLayerLineJoin.round
        arrowLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.cornerRadius = rect.size.width/2
        self.layer.masksToBounds = true
        self.layer.addSublayer(arrowLayer)
        self.backgroundColor = .clear
        
    }
}

extension UIBezierPath {
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        self.move(to: start)
        self.addLine(to: end)
        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))
        self.addLine(to: arrowLine1)
        self.move(to: end)
        self.addLine(to: arrowLine2)
    }
}

