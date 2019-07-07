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
        let client = ForecastClient(appId: "81eaa1dfd3d6c25914722a61a966baf8")
        window?.rootViewController = UINavigationController(rootViewController: FindLocationConfig.setup(api: client))
//        window?.rootViewController = FindLocationConfig.setup(api: client)
        window?.makeKeyAndVisible()
        

    }
    
    func setUI() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
}

func aprint(_ any: Any, function: String = #function, file: String = #file, line: Int = #line) {
    let fileName = file.lastPathComponent
    print("🍏\(any)- - - - - - - - - - - - - - - - - - - - - \(fileName!) || \(function) || \(line)")
}

extension String {
    var ns: NSString {
        return self as NSString
    }
    var pathExtension: String? {
        return ns.pathExtension
    }
    var lastPathComponent: String? {
        return ns.lastPathComponent
    }
}
