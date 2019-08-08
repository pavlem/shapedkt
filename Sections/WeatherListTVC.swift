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
        
        setUI()
    }

    // MARK: - Helper
    private func setUI() {
        weatherStandardChooser.setTitle("Metric".localized, forSegmentAt: MeasuringSystem.metric.rawValue)
        weatherStandardChooser.setTitle("Imperial".localized, forSegmentAt: MeasuringSystem.imperial.rawValue)
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
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell_ID", for: indexPath) as! WeatherListCell
        weatherCell.wData.text = weatherDataList?[indexPath.row]
//        weatherCell.textLabel?.text = weatherDataList?[indexPath.row]
        return weatherCell
    }
    
    // MARK: - Actions
    @IBAction func strandardOption(_ sender: UISegmentedControl) {
        
        switch MeasuringSystem(rawValue: sender.selectedSegmentIndex)! {
        case .metric:
            aprint("metric")
            currentWeatherViewModel?.isMetric = true
            reloadUI()
        case .imperial:
            currentWeatherViewModel?.isMetric = false
            reloadUI()
            aprint("imperial")
        }
    }
}

extension WeatherListTVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        weatherVC?.tempAndIcon.alpha = 1 - (scrollView.contentOffset.y / 200)
        weatherVC?.temperatureLbl.alpha = 1 - (scrollView.contentOffset.y / 200)
        
//        print(scrollView.contentOffset.y)
//        guard scrollView.contentOffset.y > 0 else { return }
        guard let cst = weatherVC?.testCst else { return }
//        guard cst.constant > 0 else { return }
        if 50 - scrollView.contentOffset.y < 0 {
            return
        } else {
            weatherVC?.tvContainerTopC.constant = 100 - scrollView.contentOffset.y
            cst.constant = 50 - scrollView.contentOffset.y
//            aprint( 1 - (1 / (50 - scrollView.contentOffset.y)) )
//            weatherVC?.tempAndIcon.alpha = 1 - (1 / (50 - scrollView.contentOffset.y))
//            weatherVC?.tempAndIcon.alpha = 1 - (1 / (50 - scrollView.contentOffset.y))

        }
    }
}
