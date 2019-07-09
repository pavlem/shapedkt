//
//  FindLocationViewController.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import MapKit

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
        
        let point = gesture.location(in: mapView)
        print("""
        --- FIND LOCATION
        --- Map tapped at point
        """)
        dump(point)
        print("--- END OF TAP ---")
        
        let touchPoint = gesture.location(in: self.mapView)
        let newCoordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        print(newCoordinate)
        print(newCoordinate.latitude)
        print(newCoordinate.longitude)
        
//        self.showShapeAlert(text: "test")
        
        
        let paja = CLLocationCoordinate2D(latitude: -9.960892521935094, longitude: -71.81640625000004)
        aprint(paja)
        
        
        let coordAsString = Coordinates(clLocationCoordinate2D: newCoordinate)
        aprint(coordAsString)
        
//        let weatherVC = UIStoryboard.weatherVC
//        self.navigationController?.pushViewController(weatherVC, animated: true)
        
//        self.output.locationSelected(at: newCoordinate)
    }
    
}

struct Coordinates {
    
    let latitude: String?
    let longitude: String?
    
    init(clLocationCoordinate2D: CLLocationCoordinate2D) {
        latitude = String(clLocationCoordinate2D.latitude)
        longitude = String(clLocationCoordinate2D.longitude)
    }
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension FindLocationVC: FindLocationPresenterOutput {
    func pajaInVC() {
        aprint("pajaInVC()")
    }
}
