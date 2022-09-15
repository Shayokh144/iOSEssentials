//
//  ViewController.swift
//  WatherToday
//
//  Created by Taher on 13/6/22.
//

import UIKit
import RxSwift

let errorCode: Double = 999
let blankWeather = WeatherModel(main: Weather(temp: errorCode, humidity: errorCode))
class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.accessibilityIdentifier = "cityNameTextFieldId"
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
        /*let searchResultDriver = URLRequest.load(resource: resource)
            .asObservable().asDriver(onErrorJustReturn: blankWeather)*/

        let searchResultDriver = URLRequest.loadOrThroughError(resource: resource)
            .asObservable()
            .retry(5)
            .catch { error in
                print(error.localizedDescription)
                return Observable.just(blankWeather)
            }
            .asObservable()
            .asDriver(onErrorJustReturn: blankWeather)

        searchResultDriver.map {
            if $0.main.temp != errorCode {
                return "\($0.main.temp) ℃"
            }
            return "X _ ℃"
        }
        .drive(self.temperatureLabel.rx.text).disposed(by: disposeBag)

        searchResultDriver.map {
            if $0.main.humidity != errorCode {
                return "\($0.main.humidity) %"
            }
            return "X _ %"
        }
        .drive(self.humidityLabel.rx.text).disposed(by: disposeBag)
    }

}
