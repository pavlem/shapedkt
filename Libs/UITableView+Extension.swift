//
//  UITableView+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/20/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

extension UITableView {
    func hideTableFooterView() {
        tableFooterView = UIView(frame: CGRect.zero)
        tableFooterView!.isHidden = true
    }
    
    func addTableFooterView(footerViewHeight: CGFloat = 20, color: UIColor = UIColor.darkGray) {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.frame.width, height: footerViewHeight))
        footerView.backgroundColor = color
        tableFooterView = footerView
    }
    
    func addTableHeaderView(headerViewHeight: CGFloat = 20, color: UIColor = UIColor.darkGray) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.frame.width, height: headerViewHeight))
        headerView.backgroundColor = color
        tableHeaderView = headerView
    }
}
