//
//  FindLocationInteractor.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities
import Client

protocol FindLocationInteractorOutput: class {
    func presentData(currentWeather: CurrentWeather)
    func presentErr(_ error: Client.Error)
}

protocol FindLocationInteractorAction: class {
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}


final class FindLocationInteractor {
    
    var output: FindLocationInteractorOutput!
    var action: FindLocationInteractorAction!
    
    let api: ForecastClient
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationInteractor: FindLocationVCOutput {
    func viewIsReady() { }
    
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        action.locationSelected(at: coordinate)
    }
}
