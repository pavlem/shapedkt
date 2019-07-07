//
//  String+Extension.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return localizedWithComment(comment: "")
    }
    
    func localizedWithComment(comment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}
