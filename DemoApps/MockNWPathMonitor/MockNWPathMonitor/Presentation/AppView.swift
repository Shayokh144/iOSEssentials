//
//  AppView.swift
//  MockNWPathMonitor
//
//  Created by Taher on 24/10/23.
//

import SwiftUI

struct AppView: View {

    @ObservedObject var viewModel: AppViewModel
    @State var counter = 0

    var body: some View {
        VStack {
            switch viewModel.networkStatus {
            case .undetermined:
                Text("UDETERMINED..")
                    .foregroundColor(.blue)
            case .notConnected:
                Text("DISCONNECTED..")
                    .foregroundColor(.red)
            case .connected:
                Text("CONNECTED..")
                    .foregroundColor(.green)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
