//
//  BlockingScreen.swift
//  forecast
//
//  Created by Pavle Mijatovic on 8/10/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class BlockingScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BlockingScreen {
    static func start() {
        let blockingScr = BlockingScreen(frame: UIScreen.main.bounds)
        setActivityIndicator(onView: blockingScr)
        UIApplication.shared.keyWindow?.addSubview(blockingScr)
    }
    
    static func setActivityIndicator(onView view: UIView) {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = view.center
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    static func stop() {
        if let keyWindow = UIApplication.shared.keyWindow {
            for view in keyWindow.subviews where view is BlockingScreen {
                view.removeFromSuperview()
            }
        }
    }
}
