//  UIImage+Icons.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.

import UIKit

extension UIImage {
    
    enum Card {
        static var defaultCard: UIImage { return UIImage(named: "receipt-beeptify")! }
        static var none: UIImage { return UIImage(named: "receipt-beeptify")! }
        static var unknown: UIImage { return UIImage(named: "receipt-beeptify")! }
        static var masterCard: UIImage { return UIImage(named: "debit-mastercard")! }
        static var visa: UIImage { return UIImage(named: "debit-visa")! }
        static var maestro: UIImage { return UIImage(named: "debit-maestro")! }
        static var dankort: UIImage { return UIImage(named: "debit-visa")! }
        static var visaDankort: UIImage { return UIImage(named: "debit-visa-dankort")! }
    }
    
    static var sliderThumb: UIImage { return UIImage(named: "debit-pay-slider-thumb")! }
    static var cancelBtnImg: UIImage { return UIImage(named: "x")! }
    static var cancelBtnGrayImg: UIImage { return UIImage(named: "x-grey")! }
    static var addAccountCreditcard: UIImage { return UIImage(named: "add-account-creditcard")! }
    static var sagLogo: UIImage { return UIImage(named: "sag-logo")! }
    static var backgroundImg: UIImage { return UIImage(named: "backgroundImg")! }
    
    // MARK: BasketControlVC
    enum SGAlert {
        static var negativeImg: UIImage { return UIImage(named: "sgAlertNegativeImg")! }
        static var positiveImg: UIImage { return UIImage(named: "sgAlertPositiveImg")! }
    }
    
    enum BasketControl {
        static var warning: UIImage { return UIImage(named: "basketControlNotOkImg")! }
        static var ok: UIImage { return UIImage(named: "basketControlOkImg")! }
    }
    
    enum CustomAlert {
        static var warning: UIImage { return UIImage(named: "customAlertImgNotOk")! }
        static var ok: UIImage { return UIImage(named: "customAlertImgOk")! }
    }
}

extension UIButton {
    static var cancel: UIButton {
        let cancelBtn = UIButton()
        cancelBtn.setImage(UIImage.cancelBtnImg, for: .normal)
        cancelBtn.setImage(UIImage.cancelBtnGrayImg, for: .highlighted)        
        return cancelBtn
    }
}
