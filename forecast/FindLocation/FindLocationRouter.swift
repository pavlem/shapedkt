
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
}

extension FindLocationRouter: FindLocationInteractorAction {

    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        
        let coordinates = Coordinates(clLocationCoordinate2D: coordinate)
        
        api.perform(CurrentWeather.getCurrent(forLatitude: coordinates.latitude!, longitude: coordinates.longitude!)) { (result) in
            
            switch result {
            case .success(let weather):
                aprint(weather)
                self.output.presentData(currentWeather: weather)
            case .failure(let err):
                aprint(err)
            }
//            aprint(result)
        }
    }
}


