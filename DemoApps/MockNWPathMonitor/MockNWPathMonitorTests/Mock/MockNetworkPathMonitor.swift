//
//  MockNetworkPathMonitor.swift
//  MockNWPathMonitorTests
//
//  Created by Taher on 24/10/23.
//

@testable import MockNWPathMonitor
import Network

final class MockNetworkPathMonitor: NetworkPathMonitorProtocol {

    var pathUpdateHandler: ((NWPath.Status) -> Void)?
    var currentNetworkStatus : NWPath.Status

    var isStartCalled = false
    var isCancelCalled = false

    init(currentNetworkStatus : NWPath.Status = .unsatisfied) {
        self.currentNetworkStatus = currentNetworkStatus
    }

    func start(queue: DispatchQueue) {
        isStartCalled = true
        pathUpdateHandler?(currentNetworkStatus)
    }

    func cancel() {
        isCancelCalled = true
    }
}
