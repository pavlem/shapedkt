//
//  UIImage+Icons.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.

import UIKit

protocol ShapeAlertProtocol: class  {
    func alertDismissed()
    func alertPresented()
}

enum ShapeAlertType {
    case positive
    case negative
}

class ShapeAlert: UIView {
    
    // MARK: - API
    weak var delegate: ShapeAlertProtocol?
    
    func showAlert(animated: Bool) {
        show(animated: animated)
    }
    
    func dismissAlert(animated: Bool) {
        dismiss(animated: animated)
    }
    
    var timeoutForDismiss: Double?
    
    // MARK: - Properties
    private var backgroundView = UIView()
    private var infoView = UIView()
    
    // MARK: Vars
    private var dismissTimer: Timer?
    // MARK: Constants
    private let animationDuration = 0.3
    private let defaultTimeoutForDismiss = 10.0
    private let lblPadding = CGFloat(30)
    private let imageHeightAndWidth = CGFloat(45)
    private let paddingBetweenImgAndLbl = CGFloat(21)

    // MARK: Calculated
    private var imgViewTopPadding: CGFloat {
        return UIApplication.shared.keyWindow!.safeAreaInsets.top
    }
    
    // MARK: - Inits
    convenience init(title: String, type: ShapeAlertType? = .positive, isDismissedAfterTimeout: Bool = false, timeoutForDismiss: Double? = nil) {
        self.init(frame: UIScreen.main.bounds)
        
        initialize(title: title, type: type)
        
        if isDismissedAfterTimeout {
            if timeoutForDismiss != nil {
                self.timeoutForDismiss = timeoutForDismiss!
            }
            addDissmissTimer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        self.dismissTimer?.invalidate()
    }
    
    // MARK: - Helper
    func initialize(title: String, type: ShapeAlertType? = .positive) {
        setBackgroundView()
        setInfoView(type: type!)
        addCloseBtn(toView: infoView, closeTxt: "AlertCloseBtn".localized)
        let imageView = addImageView(type: type!, toView: infoView)
        let titleLabel = addTitleLbl(type: type!, title: title, imageView: imageView, toView: self.infoView)
        imageView.center = CGPoint(x: self.infoView.bounds.midX, y: self.infoView.bounds.midY);
        imageView.frame.origin.y = imgViewTopPadding
        let dialogViewHeight = imageView.frame.origin.y + imageView.frame.height + 21 + titleLabel.frame.height + 10
        infoView.frame.size.height = dialogViewHeight
        self.infoView.frame.origin.y =  -self.infoView.frame.size.height
    }
    
    func setInfoView(type: ShapeAlertType, toView view: UIView? = nil) {
        infoView.clipsToBounds = true
        infoView.frame.size = CGSize(width: frame.width, height: 0)
        infoView.backgroundColor = color(forType: type)
        infoView.alpha = 0.0
        
        if view != nil {
            view!.addSubview(infoView)
        } else {
            addSubview(infoView)
        }
    }
    
    func addImageView(type: ShapeAlertType, toView view: UIView) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image(forType: type)
        imageView.frame.size.height = imageHeightAndWidth
        imageView.frame.size.width = imageView.frame.size.height
        imageView.frame.origin.y = imgViewTopPadding
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        return imageView
    }
    
    func addTitleLbl(type: ShapeAlertType, title: String, imageView: UIImageView, toView view: UIView) -> UILabel {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width - (lblPadding * 2), height: 0))
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.center = infoView.center
        titleLabel.frame.origin.y = imageView.frame.origin.y + imageView.frame.height + paddingBetweenImgAndLbl
        
        view.addSubview(titleLabel)
        return titleLabel
    }
    
    func addCloseBtn(toView view: UIView, closeTxt: String) {
        let button = UIButton()
        button.setTitle(closeTxt, for: .normal)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.setTitleColor(.gray, for: UIControl.State.highlighted)
        button.sizeToFit()
        button.frame = CGRect(x: view.frame.size.width - button.frame.size.width - 20, y: 20, width: button.frame.width, height: button.frame.height)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        let yourAttributes1: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let yourAttributes2: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.gray,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString1 = NSMutableAttributedString(string: closeTxt,
                                                         attributes: yourAttributes1)
        let attributeString2 = NSMutableAttributedString(string: closeTxt,
                                                         attributes: yourAttributes2)
        button.setAttributedTitle(attributeString1, for: .normal)
        button.setAttributedTitle(attributeString2, for: .highlighted)
        button.sizeToFit()
        view.addSubview(button)
    }
    
    func image(forType type: ShapeAlertType) -> UIImage {
        switch type {
        case .positive:
            return UIImage.SGAlert.positiveImg
        case .negative:
            return UIImage.SGAlert.negativeImg
        }
    }
    
    func color(forType type: ShapeAlertType) -> UIColor {
        switch type {
        case .positive:
            return UIColor.SGAlert.positive
        case .negative:
            return UIColor.SGAlert.negative
        }
    }
    
    func addDissmissTimer() {
        self.dismissTimer = Timer.scheduledTimer(timeInterval: timeoutForDismiss ?? defaultTimeoutForDismiss, target: self, selector: #selector(self.closeToast), userInfo: nil, repeats: false)
    }
    
    func setBackgroundView() {
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.alpha = 0.0
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        backgroundView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.backgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurEffectView)
    }
    
    // MARK: - Actions
    @objc func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTappedOnBackgroundView() {
        dismiss(animated: true)
    }
    
    @objc func closeToast(timer: Timer) {
        dismiss(animated: true)
    }
    
    // MARK: - Helper - Actions
    private func show(animated: Bool) {
        
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        
        if animated {
            UIView.animate(withDuration: animationDuration, animations: {
                self.infoView.frame.origin.y = 0
                self.backgroundView.alpha = 1.0
                self.infoView.alpha = 1.0
                self.delegate?.alertPresented()
            })
        } else {
            self.backgroundView.alpha = 1.0
            self.backgroundView.frame.origin.y =  0
            self.delegate?.alertPresented()
        }
    }
    
    private func dismiss(animated: Bool) {
        if animated {
            UIView.animate(withDuration: animationDuration, animations: {
                self.infoView.frame.origin.y =  -self.infoView.frame.size.height
                self.backgroundView.alpha = 0.0
                self.infoView.alpha = 0.0
            }, completion: { (completed) in
                self.removeFromSuperview()
                self.delegate?.alertDismissed()
            })
        } else {
            self.removeFromSuperview()
            self.delegate?.alertDismissed()
        }
    }
}
