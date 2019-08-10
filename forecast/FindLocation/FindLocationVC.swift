//
//  FindLocationViewController.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import MapKit
import Entities
import Client

protocol FindLocationVCOutput: class {
    func viewIsReady()
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}

final class FindLocationVC: BaseVC {

    // MARK: - API
    var output: FindLocationVCOutput!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Properties
    private lazy var mapView: MKMapView = MKMapView(frame: .zero)
    
    // MARK: - Helper
    func setUI() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(findLocation(_:)))
        mapView.addGestureRecognizer(gesture)
    }
    
    // MARK: - Actions
    @objc private func findLocation(_ gesture: UITapGestureRecognizer) {
        
        guard ReachabilityHelper.shared.reachability.connection != .none else {
            showNoInternetAlert()
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let touchPoint = gesture.location(in: self.mapView)
        let newCoordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        self.output.locationSelected(at: newCoordinate)
        BlockingScreen.start()
    }
}

extension FindLocationVC: FindLocationPresenterOutput {
    func presentError(_ error: Client.Error) {
        
        switch error {
        case .client(let text):
            aprint(text)
        case .network(let err, _):
            self.showShapeAlert(text: err.localizedDescription, isPositiveAlert: false)
            print(err.localizedDescription)
        case .parser(let err):
            self.showShapeAlert(text: err.localizedDescription, isPositiveAlert: false)
            print(err)
        case .remote(let err, _):
            self.showShapeAlert(text: err.localizedDescription, isPositiveAlert: false)
        }
    }
    
    func presentData(currentWeather: CurrentWeather) {
        let currentWeatherViewModel = CurrentWeatherViewModel(weather: currentWeather)
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            BlockingScreen.stop()

            let weatherVC = UIStoryboard.weatherVC
            weatherVC.currentWeatherViewModel = currentWeatherViewModel
            weatherVC.backgroundImg = self.view.takeScreenshot()
            self.navigationController?.customPush(weatherVC)
        }
    }
}
