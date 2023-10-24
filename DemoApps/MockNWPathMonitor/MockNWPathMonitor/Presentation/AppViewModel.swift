//
//  AppViewModel.swift
//  MockNWPathMonitor
//
//  Created by Taher on 24/10/23.
//

import Foundation

enum NetworkStatus {

    case undetermined
    case notConnected
    case connected
}

final class AppViewModel: ObservableObject {

    @Published var networkStatus: NetworkStatus = .undetermined
    var networkMonitor: NetworkPathMonitorProtocol

    public init(networkMonitor: NetworkPathMonitorProtocol) {
        self.networkMonitor = networkMonitor
        self.networkMonitor.pathUpdateHandler = { [weak self] status in
            DispatchQueue.main.async { [weak self] in
                self?.networkStatus = status == .satisfied ? .connected : .notConnected
            }
        }
        self.networkMonitor.start(queue: DispatchQueue.global())
    }

    deinit {
        networkMonitor.cancel()
    }
}
