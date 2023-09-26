//
//  ContentViewModel.swift
//  Network Monitor
//
//  Created by Taher on 22/8/23.
//

import Foundation

final class ContentViewModel: ObservableObject {

    @Published var isConnected = false
    var networkMonitor: NetworkPathMonitorProtocol

    init(networkMonitor: NetworkPathMonitorProtocol) {
        self.networkMonitor = networkMonitor
        self.networkMonitor.pathUpdateHandler = { [weak self] status in
            print("THREAD : \(Thread.isMainThread)")
            guard let owner = self else { return }
            if status == .satisfied {
                print("CONNECTED")
            } else {
                print("DISCONNECTED")
            }
            DispatchQueue.main.async { [weak self] in
                self?.isConnected = status == .satisfied
            }
        }
        self.networkMonitor.start(queue: DispatchQueue.global())
    }

    deinit {
        networkMonitor.cancel()
    }
}
