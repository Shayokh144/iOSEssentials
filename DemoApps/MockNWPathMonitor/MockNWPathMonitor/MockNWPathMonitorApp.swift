//
//  MockNWPathMonitorApp.swift
//  MockNWPathMonitor
//
//  Created by Taher on 24/10/23.
//

import SwiftUI

@main
struct MockNWPathMonitorApp: App {

    var body: some Scene {
        WindowGroup {
            AppView(
                viewModel: AppViewModel(
                    networkMonitor: NetworkPathMonitor()
                )
            )
        }
    }
}
