//
//  Network_MonitorApp.swift
//  Network Monitor
//
//  Created by nimble on 22/8/23.
//

import SwiftUI

@main
struct NetworkMonitorApp: App {
    let network = NetworkPathMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentViewModel(networkMonitor: network)
            )
        }
    }
}
