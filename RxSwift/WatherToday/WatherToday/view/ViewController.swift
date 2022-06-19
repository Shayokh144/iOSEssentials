//
//  ViewController.swift
//  WatherToday
//
//  Created by nimble on 13/6/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        displayWeather(weatherData: nil)
        textField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .withUnretained(self)
            .map { _ in self.textField.text }
            .subscribe(
                onNext: { cityName in
                    if let city = cityName {
                        if city.count > 2 {
                            self.fetchWeather(for: city)
                        } else {
                            self.displayWeather(weatherData: nil)
                        }
                    }
                }
            ).disposed(by: disposeBag)
    }

    private func displayWeather(weatherData: Weather?) {
        if let weather = weatherData {
            temperatureLabel.text = "\(weather.temp) ℃"
            humidityLabel.text = "\(weather.humidity) %"
        }
        else {
            temperatureLabel.text = "_ ℃"
            humidityLabel.text = "_ %"
        }
    }

    private func fetchWeather(for cityName: String) {
        // this encoding is needed for the city names which have spaces
        guard let cityEncoded = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let urlData = URL.URLForWeatherApi(for: cityEncoded) else {
            return
        }
        let resource = Resource<WeatherModel>(url: urlData)
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] result in
                    let weather = result.main
                    self?.displayWeather(weatherData: weather)
                },
                onError: {error in
                    print("Error: \(error.localizedDescription)")
                    self.displayWeather(weatherData: nil)
                },
                onCompleted: {
                    print("completed Data fetching")
                }
            )
            .disposed(by: disposeBag)
    }

}
