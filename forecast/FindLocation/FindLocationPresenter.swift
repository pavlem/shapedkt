//
//  FindLocationPresenter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities

protocol FindLocationPresenterOutput: class {
    func presentData(currentWeather: CurrentWeather)
    func presentErr()
}

final class FindLocationPresenter {
    weak var output: FindLocationPresenterOutput!
}

extension FindLocationPresenter: FindLocationInteractorOutput {
    func presentData(currentWeather: CurrentWeather) {
        output.presentData(currentWeather: currentWeather)
    }
    
    func presentErr() {
        output.presentErr()
    }
}
