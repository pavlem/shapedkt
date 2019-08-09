//
//  WeatherListTVC.swift
//  forecast
//
//  Created by Pavle Mijatovic on 8/4/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class WeatherListTVC: UITableViewController {
    
    // MARK: - API
    var currentWeatherViewModel: CurrentWeatherViewModel? {
        didSet {
            reloadUI()
        }
    }
    
    // MARK: - Properties
    // MARK: Outlets
    @IBOutlet weak var tableviewHeader: UIView!
    @IBOutlet weak var longerDescriptionLbl: UILabel!
    @IBOutlet weak var weatherStandardChooser: UISegmentedControl!
    // MARK: Vars
    private var weatherDataList: [String]?
    private var weatherVC: WeatherVC? {
        if let wVC = self.parent as? WeatherVC {
            return wVC
        }
        return nil
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTxt()
        setUI()
    }

    // MARK: - Helper
    private func setTxt() {
        weatherStandardChooser.setTitle("Metric".localized, forSegmentAt: MeasuringSystem.metric.rawValue)
        weatherStandardChooser.setTitle("Imperial".localized, forSegmentAt: MeasuringSystem.imperial.rawValue)
    }
    
    private func setUI() {
        longerDescriptionLbl.textColor = .white
        weatherStandardChooser.tintColor = .white
    }
    
    private func reloadUI() {
        weatherDataList = currentWeatherViewModel?.weatherDataArray
        longerDescriptionLbl.text = currentWeatherViewModel?.detailesDescription
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.id, for: indexPath) as! WeatherListCell
        weatherCell.weatherData = WeatherListData(wData: weatherDataList?[indexPath.row])
        return weatherCell
    }
    
    // MARK: - Actions
    @IBAction func strandardOption(_ sender: UISegmentedControl) {
        switch MeasuringSystem(rawValue: sender.selectedSegmentIndex)! {
        case .metric:
            currentWeatherViewModel?.isMetric = true
            reloadUI()
        case .imperial:
            currentWeatherViewModel?.isMetric = false
            reloadUI()
        }
    }
}

extension WeatherListTVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        weatherVC?.tempAndIcon.alpha = 1 - (scrollView.contentOffset.y / tableviewHeader.frame.size.height) //200
        
        if 50 - scrollView.contentOffset.y < 0 {
            return
        } else {
            weatherVC!.tvContainerTopC.constant = 110 - scrollView.contentOffset.y
            weatherVC!.infoViewTopC.constant = 50 - scrollView.contentOffset.y
        }
    }
}
