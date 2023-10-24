//
//  ContentViewModel.swift
//  Network Monitor
//
//  Created by Taher on 22/8/23.
//

import Foundation

enum NetworkStatus {

    case undetermined
    case notConnected
    case connected
}

final class ContentViewModel: ObservableObject {

    @Published var networkStatus: NetworkStatus = .undetermined
    var networkMonitor: NetworkPathMonitorProtocol

    public init(networkMonitor: NetworkPathMonitorProtocol) {
        self.networkMonitor = networkMonitor
        self.networkMonitor.pathUpdateHandler = { [weak self] status in
            print("THREAD : \(Thread.isMainThread)")
            if status == .satisfied {
                print("CONNECTED")
            } else {
                print("DISCONNECTED")
            }
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
