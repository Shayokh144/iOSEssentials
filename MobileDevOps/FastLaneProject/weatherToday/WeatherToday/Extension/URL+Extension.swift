//
//  URL+Extension.swift
//  WatherToday
//
//  Created by Taher on 19/6/22.
//

import Foundation

extension URL {
    static func URLForWeatherApi(for city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=34e43ac725f3679763f219f9d2de0801&units=metric")

    }
}
