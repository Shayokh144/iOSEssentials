//
//  ContentView.swift
//  Network Monitor
//
//  Created by Taher on 22/8/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
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
            Button {
                counter += 1
            } label: {
                Text("Counter \(counter)")
                    .frame(width: 120, height: 50)
            }
            .border(SelectionShapeStyle.init())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
