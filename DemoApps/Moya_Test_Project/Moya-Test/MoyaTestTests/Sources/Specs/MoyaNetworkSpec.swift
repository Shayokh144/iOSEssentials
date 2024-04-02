//
//  MoyaNetworkSpec.swift
//  MoyaTestTests
//
//  Created by Taher on 2/12/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Moya
import Nimble
import Quick
import RxSwift

@testable import MoyaTest

final class MoyaNetworkSpec: QuickSpec {

    override func spec() {
        let disposeBag = DisposeBag()
        let data = Data("NO ACCESS, error 401".utf8)
        var isError: Bool!
        var stubbedProvider: MoyaProvider<MultiTarget>!
        var networkApi: NetworkAPI!

        describe("a moya network test") {

            beforeEach {
                isError = false
                let customEndpointClosure = { (target: TargetType) -> Endpoint in
                    Endpoint(
                        url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(401, data) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers
                    )
                }
                stubbedProvider = MoyaProvider<MultiTarget>(
                    endpointClosure: customEndpointClosure,
                    stubClosure: MoyaProvider.immediatelyStub
                )
                networkApi = NetworkAPI(provider: stubbedProvider)
            }

            context("when mock response provided") {
                beforeEach {
                    getWeatherData(
                        for: WeatherRequestConfiguration.weather(
                            cityName: "Dhaka"
                        ),
                        apiType: WeatherApi.self
                    )
                }

                it("return mock error response") {
                    expect(isError) == true
                }
            }
        }

        func getWeatherData<T: Decodable>(for target: TargetType, apiType: T.Type) {
            networkApi
                .performRequest(target, for: apiType)
                .subscribe(
                    with: self,
                    onSuccess: { _, data in
                        print("DATA:\(data)")
                    },
                    onFailure: { _, error in
                        print("ERROR: \(error)")
                        isError = true
                    }
                )
                .disposed(by: disposeBag)
        }
    }
}
