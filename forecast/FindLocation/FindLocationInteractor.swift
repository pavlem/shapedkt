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

protocol FindLocationInteractorOutput: class {
    func presentData()
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
    func viewIsReady() {
        // Request example to load the current weather with a query
        // Documentation for using the OpenWeatherAPI, is available at https://openweathermap.org/api
//        api.perform(CurrentWeather.getCurrent(forLatitude: "51.51", longitude: "-013")) { (result) in
//            print("""
//            --- EXAMPLE
//            --- Current weather for location "London, UK"
//            """)
//            dump(result)
//            print("--- END OF EXAMPLE ---")
//        }
    }
    
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        
        
//        api.perform(CurrentWeather.getCurrent(forLatitude: "51.51", longitude: "-013")) { (result) in
//            print("""
//            --- EXAMPLE
//            --- Current weather for location "London, UK"
//            """)
//            dump(result)
//            print("--- END OF EXAMPLE ---")
//        }
//        action.locationSelected(at: coordinate)
        
        
//        output.paja()
        
        action.locationSelected(at: coordinate)
    }
}
