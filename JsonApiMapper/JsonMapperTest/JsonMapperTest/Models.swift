//
//  Models.swift
//  JsonMapperTest
//
//  Created by Taher on 15/11/22.
//

import Foundation

struct SurveyList: Decodable {
    let type: String
    let title: String
}

protocol Weather {
    var temp: Double { get }
    var humidity: Double { get }
}

struct WeatherApi: Decodable, Weather {

    let temp: Double
    let humidity: Double
}
