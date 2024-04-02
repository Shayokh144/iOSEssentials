//
//  WeatherRequestConfiguration.swift
//  MoyaTest
//
//  Created by Taher on 2/12/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Moya

enum WeatherRequestConfiguration {

    /// Add cases for each endpoint
    case weather(cityName: String)
}

extension WeatherRequestConfiguration: TargetType {

    /// Return base URL for a target
    var baseURL: URL { URL(string: "https://api.openweathermap.org/")! }
    /// Return endpoint path for each endpoint case
    var path: String { "data/2.5/weather" }
    /// Return HTTP method for each endpoint case
    var method: Moya.Method { .get }
    /// Build and Return HTTP task for each endpoint case
    var task: Moya.Task {
        switch self {
        case let .weather(cityName):
            return Task.requestParameters(
                parameters: [
                    "q": cityName,
                    "appid": "34e43ac725f3679763f219f9d2de0801",
                    "units": "metric"
                ],
                encoding: URLEncoding.default
            )
        }
    }

    /// Return the appropriate HTTP headers for every endpoint case
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    /// Return stub/mock data for use in testing. Default is `Data()`
    var sampleData: Data { Data() }
    /// Return the type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType { .successCodes }
}
