//
//  BaseVC.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReachabilityHelper.shared.delegate = self
    }
    
    // MARK: - Helper
    func showSGAlert(text: String, isPositiveAlert: Bool = true, isDismissedAfterTimeout: Bool = false, timeoutForDismiss: Double? = nil) {
        DispatchQueue.main.async {
//            let sgAlert = SGAlert.init(title: text, type: isPositiveAlert ? SGAlertType.positive : SGAlertType.negative, isDismissedAfterTimeout: true, timeoutForDismiss: timeoutForDismiss)
//            sgAlert.delegate = self
//            sgAlert.showAlert(animated: true)
        }
    }
}

// MARK: - ReachabilityHelperProtocol
extension BaseVC: ReachabilityHelperProtocol {
    @objc func noInternet() {
        self.showSGAlert(text: "Common_NetworkError".localized, isPositiveAlert: false)
        aprint("BaseVC - noInternet()")
    }
    
    @objc func online() {
        aprint("BaseVC - online()")
    }
}
