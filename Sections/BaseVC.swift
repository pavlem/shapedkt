//
//  BaseVC.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

protocol Blurrable: BaseVC {
    func blurrBackground()
}

extension Blurrable {
    private var blurView: UIView {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    func blurrBackground() {
        guard let topPresentedViewController = UIApplication.topPresentedViewController else { return }
        topPresentedViewController.definesPresentationContext = true
        view.insertSubview(blurView, at: 0)
    }
}

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
    
    func addBackButton(color: UIColor? = nil) {
        let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top
        let btnWH = CGFloat(30)
        let leadDistance = CGFloat(8)
        let toDistance = CGFloat(8)

        let buttonImg = UIImage.backBtnImg
        let buttonImgColored = buttonImg.maskWithColor(color: color ?? .black)
        let btn = UIButton(frame: CGRect(x: leadDistance, y: topPadding! + toDistance, width: btnWH, height: btnWH))
        btn.setImage(buttonImgColored, for: .normal)
        btn.addTarget(self, action: #selector(self.backBtn), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    // MARK: - Actions
    @objc func backBtn() {
        if let nc = self.navigationController {
            nc.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
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
