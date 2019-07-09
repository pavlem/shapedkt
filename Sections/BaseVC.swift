//
//  BaseVC.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit


// MARK: - SGAlertProtocol
extension BaseVC: ShapeAlertProtocol {
    func alertDismissed() { }
    func alertPresented() { }
}


class BaseVC: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReachabilityHelper.shared.delegate = self
    }
    
    // MARK: - Helper
    func showShapeAlert(text: String, isPositiveAlert: Bool = true, isDismissedAfterTimeout: Bool = false, timeoutForDismiss: Double? = nil) {
        DispatchQueue.main.async {
            let sgAlert = ShapeAlert.init(title: text, type: isPositiveAlert ? ShapeAlertType.positive : ShapeAlertType.negative, isDismissedAfterTimeout: true, timeoutForDismiss: timeoutForDismiss)
            sgAlert.delegate = self
            sgAlert.showAlert(animated: true)
        }
    }
    
    func showNoInternetAlert() {
        DispatchQueue.main.async {
            let sgAlert = ShapeAlert.init(title: "Common_NetworkError".localized, type: ShapeAlertType.negative, isDismissedAfterTimeout: true)
            sgAlert.delegate = self
            sgAlert.showAlert(animated: true)
        }
    }
}

// MARK: - ReachabilityHelperProtocol
extension BaseVC: ReachabilityHelperProtocol {
    @objc func noInternet() {
        self.showShapeAlert(text: "Common_NetworkError".localized, isPositiveAlert: false)
        aprint("BaseVC - noInternet()")
    }
    
    @objc func online() {
        aprint("BaseVC - online()")
    }
}
