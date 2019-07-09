
//
//  FindLocationRouter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities

final class FindLocationRouter {
    let api: ForecastClient
    
    weak var output: FindLocationPresenterOutput!

    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
    
    var dataTask: URLSessionTask?
}

extension FindLocationRouter: FindLocationInteractorAction {

    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        
        self.dataTask?.cancel()
        
        let coordinates = Coordinates(clLocationCoordinate2D: coordinate)
        
        self.dataTask = api.perform(CurrentWeather.getCurrent(forLatitude: coordinates.latitude!, longitude: coordinates.longitude!)) { (result) in
            
            switch result {
            case .success(let weather):
                self.output.presentData(currentWeather: weather)
            case .failure(let err):
                self.output.presentError(err)
                aprint(err)
            }
        }
    }
}


