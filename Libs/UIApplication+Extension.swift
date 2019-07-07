//  UIApplication+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.

import UIKit

extension UIApplication {
    static var topNavigationViewController: UINavigationController? {
        return self.topPresentedViewController as? UINavigationController
    }
    
    static var topPresentedViewController: UIViewController? {
        return self.rootViewController.flatMap { UIViewController.topPresentedViewController($0) }
    }
    
    static var rootViewController: UIViewController? {
        get {
            return self.shared.delegate!.window!!.rootViewController
        }
        
        set {
            self.shared.delegate!.window!!.rootViewController = newValue
        }
    }
}

extension UIViewController {
    fileprivate static func topPresentedViewController(_ viewController: UIViewController) -> UIViewController {
        if let presentedViewController = viewController.presentedViewController {
            return UIViewController.topPresentedViewController(presentedViewController)
        }
        
        return viewController
    }
}
