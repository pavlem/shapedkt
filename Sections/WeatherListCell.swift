//
//  WeatherListCell.swift
//  forecast
//
//  Created by Pavle Mijatovic on 8/8/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    
    static let id = "WeatherListCell_ID"

    @IBOutlet weak var wData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
