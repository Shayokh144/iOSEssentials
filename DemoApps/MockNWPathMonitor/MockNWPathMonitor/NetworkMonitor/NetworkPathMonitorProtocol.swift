//
//  NetworkPathMonitorProtocol.swift
//  MockNWPathMonitor
//
//  Created by Taher on 24/10/23.
//

import Foundation

import Network

protocol NetworkPathMonitorProtocol {

    var pathUpdateHandler: ((_ newPath: NWPath.Status) -> Void)? { get set }
    func start(queue: DispatchQueue)
    func cancel()
}
