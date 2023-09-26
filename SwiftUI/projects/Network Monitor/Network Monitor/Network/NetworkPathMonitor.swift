//
//  NetworkPathMonitor.swift
//  Network Monitor
//
//  Created by Taher on 22/8/23.
//

import Network

final class NetworkPathMonitor : NetworkPathMonitorProtocol {

    var currentPath: NWPath
    var pathUpdateHandler: ((NWPath.Status) -> Void)?
    let monitor : NWPathMonitor

    init(monitor : NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        currentPath = monitor.currentPath
        monitor.pathUpdateHandler = { [weak self] path in
            guard let owner = self else { return }
            owner.pathUpdateHandler?(path.status)
            owner.currentPath = path
        }
    }

    func start(queue: DispatchQueue) {
        monitor.start(queue: queue)
    }

    func cancel() {
        monitor.cancel()
    }
}

