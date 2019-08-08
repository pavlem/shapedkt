//
//  WeatherVC.swift
//  forecast
//
//  Created by Pavle Mijatovic on 7/7/19.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit

class WeatherVC: BaseVC, Blurrable {

    // MARK: - Outlets
    @IBOutlet weak var testCst: NSLayoutConstraint!
    @IBOutlet weak var tvContainerTopC: NSLayoutConstraint!
    
    @IBOutlet weak var tempAndIcon: UIStackView!
    @IBOutlet weak var selectedAreaLbl: UILabel!
    @IBOutlet weak var weatherDescriptionLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var weatherImgView: UIImageView!
    
    // MARK: - API
    var mainTitle: String?
    var currentWeatherViewModel: CurrentWeatherViewModel?
    var backgroundImg: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTxt()
        setUI()
        
        if let urlIcon = URL(string:  currentWeatherViewModel!.iconUrl!) {
            getData(from: urlIcon) { data, response, error  in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? urlIcon.lastPathComponent)
                DispatchQueue.main.async() {
                    self.weatherImgView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    // MARK: - Actions
    @IBAction func popBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper
    func setTxt() {
        temperatureLbl.text = currentWeatherViewModel?.currentT ?? ""
        selectedAreaLbl.text = (currentWeatherViewModel?.city ?? "") + ", " + (currentWeatherViewModel?.countryDetails.countryName ?? "")
        weatherDescriptionLbl.text = currentWeatherViewModel?.generalDescription ?? ""
    }
    
    func setUI() {
        temperatureLbl.textColor = UIColor.white
        weatherDescriptionLbl.textColor = UIColor.white
        selectedAreaLbl.textColor = UIColor.white
        
        temperatureLbl.font = UIFont.boldSystemFont(ofSize: 40)
        weatherDescriptionLbl.font = UIFont.systemFont(ofSize: 17)
        selectedAreaLbl.font = UIFont.systemFont(ofSize: 17)

        if let weeatherListTVC = self.children.first as? WeatherListTVC {
            weeatherListTVC.currentWeatherViewModel = self.currentWeatherViewModel
        }
        
        blurrBackground()

        let imageView = UIImageView(frame: UIApplication.shared.keyWindow?.frame ?? self.view.frame)
        imageView.image = backgroundImg
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
//        addBackBtn(color: .clear, isBorder: true)
        addBackButton(color: .white)
        self.navigationController?.navigationBar.isHidden = true
    }
}
