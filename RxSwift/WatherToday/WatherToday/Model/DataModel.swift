//
//  DataModel.swift
//  WatherToday
//
//  Created by nimble on 13/6/22.
//

import Foundation

struct WeatherModel: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
