
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
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationRouter: FindLocationInteractorAction {
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        
        let coordinates = Coordinates(clLocationCoordinate2D: coordinate)
        
        api.perform(CurrentWeather.getCurrent(forLatitude: coordinates.latitude!, longitude: coordinates.longitude!)) { (result) in
            print("""
                    --- EXAMPLE
                    --- Current weather for location "London, UK"
                    """)
            dump(result)
            print("--- END OF EXAMPLE ---")
        }
//        aprint("locationSelected(at coordinate: CLLocationCoordinate2D): \(coordinate)")
    }
}


