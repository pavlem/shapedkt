//
//  WeatherListCell.swift
//  forecast
//
//  Created by Pavle Mijatovic on 8/8/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

struct WeatherListData {
    let wData: String?
}

class WeatherListCell: UITableViewCell {
    
    // MARK: - API
    var weatherData: WeatherListData? {
        willSet {
            updateUI(withWeatherData: newValue)
        }
    }
    
    // MARK: - Properties
    // MARK: Outlets
    @IBOutlet weak var wData: UILabel!
    // MARK: Constants
    static let id = "WeatherListCell_ID"

    // MARK: - Helper
    private func updateUI(withWeatherData weatherData: WeatherListData?) {
        wData.text = weatherData?.wData
    }
    
    private func setUI() {
        selectionStyle = .none
        wData.textColor = .white
        wData.font = UIFont.systemFont(ofSize: 17)
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
