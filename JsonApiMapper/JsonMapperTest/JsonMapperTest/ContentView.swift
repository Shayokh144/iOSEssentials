//
//  ContentView.swift
//  JsonMapperTest
//
//  Created by Taher on 14/11/22.
//

import SwiftUI
import JSONAPIMapper

struct ContentView: View {
    var body: some View {
        VStack {
            Text(getJsonString().0)
            Text(getJsonString().1)
        }
        .padding()
    }

    init() {

    }

    private func jsonToModel() {

    }

    private func getJsonString() -> (String, String) {
        let jsonString =
        """
        {
            "temp": 298.48,
            "humidity": 64.9
        }
        """
        let decoder = JSONAPIDecoder()
        decoder.assumesTopLevelDictionary = true
        let dataToParse = Data(jsonString.utf8)
        do {
            let modelData = try decoder.decode(WeatherApi.self, from: dataToParse)
            print(modelData)
            return ("temp: \(modelData.temp)%", "humidity: \(modelData.humidity)")
        } catch let error {
            print(error.localizedDescription)
            return ("temp: _%", "humidity: _")
        }


    }
}

protocol Weather {
    var temp: Double { get }
    var humidity: Double { get }
}

struct WeatherApi: Decodable, Weather {

    let temp: Double
    let humidity: Double
}
