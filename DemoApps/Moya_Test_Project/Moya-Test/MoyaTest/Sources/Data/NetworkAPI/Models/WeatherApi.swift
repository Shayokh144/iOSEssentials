//
//  WeatherApi.swift
//  MoyaTest
//
//  Created by nimble on 2/12/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct WeatherApi: Decodable {

    enum CodingKeys: String, CodingKey {

        case main
        case temp
        case humidity
    }

    let humidity: Double
    let temperature: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        temperature = try main.decode(Double.self, forKey: .temp)
        humidity = try main.decode(Double.self, forKey: .humidity)
    }

    init(temperature: Double, humidity: Double) {
        self.temperature = temperature
        self.humidity = humidity
    }
}
