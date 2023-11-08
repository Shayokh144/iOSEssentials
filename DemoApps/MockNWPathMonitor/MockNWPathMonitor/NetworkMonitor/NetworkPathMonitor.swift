//
//  NetworkPathMonitor.swift
//  MockNWPathMonitor
//
//  Created by Taher on 24/10/23.
//

import Network

final class NetworkPathMonitor : NetworkPathMonitorProtocol {

    var pathUpdateHandler: ((NWPath.Status) -> Void)?
    let monitor : NWPathMonitor

    init(monitor : NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        monitor.pathUpdateHandler = { [weak self] path in
            guard let owner = self else { return }
            owner.pathUpdateHandler?(path.status)
        }
    }

    func start(queue: DispatchQueue) {
        monitor.start(queue: queue)
    }

    func cancel() {
        monitor.cancel()
    }
}
