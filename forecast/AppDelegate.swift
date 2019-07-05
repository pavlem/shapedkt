//
//  AppDelegate.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import API

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootVC()
        setUI()
        
        return true
    }
    
    // MARK: - Helper
    func setRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let client = ForecastClient(appId: "<your-AppId-goes-here>")
        window?.rootViewController = FindLocationConfig.setup(api: client)
        window?.makeKeyAndVisible()
    }
    
    func setUI() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
}
