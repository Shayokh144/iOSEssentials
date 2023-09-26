//
//  NetworkPathMonitorProtocol.swift
//  Network Monitor
//
//  Created by Taher on 22/8/23.
//

import Foundation

import Network

protocol NetworkPathMonitorProtocol {

    var pathUpdateHandler: ((_ newPath: NWPath.Status) -> Void)? { get set }
    func start(queue: DispatchQueue)
    func cancel()
}
