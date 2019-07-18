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
    @IBOutlet weak var backBtn: UIButton!
    
    // MARK: - API
    var mainTitle: String?
    var currentWeatherViewModel: CurrentWeatherViewModel?
    var snapshotImg: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Actions
    @IBAction func popBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper
    func setUI() {
        let imageView = UIImageView(frame: UIApplication.shared.keyWindow?.frame ?? self.view.frame)
        imageView.image = snapshotImg
        self.view.addSubview(imageView)
        
        blurrBackground()
        
        self.view.bringSubviewToFront(backBtn)
        backBtn.backgroundColor = .orange
        backBtn.layer.cornerRadius = 20
    }
}
