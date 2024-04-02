import Moya
import RxSwift
import UIKit

final class HomeViewController: UIViewController {

    let networkApi = NetworkAPI()
    private let disposeBag = DisposeBag()
    let helloLabel = UILabel()
    let cityName = "Dhaka"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        helloLabel.numberOfLines = 0
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(helloLabel)
        NSLayoutConstraint.activate([
            helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        getWeatherData(
            for: WeatherRequestConfiguration.weather(
                cityName: cityName
            ),
            apiType: WeatherApi.self
        )
    }

    private func getWeatherData<T: Decodable>(for target: TargetType, apiType: T.Type) {
        networkApi
            .performRequest(target, for: apiType)
            .subscribe(
                with: self,
                onSuccess: { _, data in
                    print("DATA:\(data)")
                    if let weatherData = data as? WeatherApi {
                        let weatherText =
                            """
                            City: \(self.cityName)
                            humidity: \(weatherData.humidity)
                            temperature: \(weatherData.temperature)
                            """
                        self.helloLabel.text = weatherText
                    }
                },
                onFailure: { _, error in
                    print("ERROR: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}
