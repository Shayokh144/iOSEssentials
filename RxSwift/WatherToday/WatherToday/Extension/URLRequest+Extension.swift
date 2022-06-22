//
//  URLRequest+Extension.swift
//  WatherToday
//
//  Created by Taher on 13/6/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import WebKit

struct Resource<T> {
    let url : URL
}

extension URLRequest {

    static func loadOrThroughError <T: Decodable> (resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url]).flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.response(request: request)
        }.map { response, data -> T in
            if 200..<300 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            }
            else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }
        }.asObservable()
    }

    static func load <T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map {data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
}
