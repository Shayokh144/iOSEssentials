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
            Text(exampleOfSingleObject().0)
        }
        .padding()
    }

    init() {

    }

    private func jsonToModel() {

    }

    private func exampleOfArrayOfObject() {
        let decoder = JSONAPIDecoder()
        let dataToParse = Data(JsonStringCollection.getSurveyString().utf8)
        do {
            let modelData = try decoder.decode([SurveyList].self, from: dataToParse)
            print(modelData)

        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func exampleOfSingleObject() -> (String, String) {
        let jsonString =
        """
                {
                  "data": {
                    "type": "articles",
                    "id": "1",
                    "attributes": {
                        "temp": 298.48,
                        "humidity": 64.9
                    }
                  }
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
