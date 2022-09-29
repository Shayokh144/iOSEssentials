//
//  ContentView.swift
//  UI_Test_Demo
//
//  Created by Taher on 23/9/22.
//

import SwiftUI

struct AuthView: View {

    @ObservedObject var viewModel: AuthViewModel

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {

        switch viewModel.authState {
        case .succeed:
            ZStack {
                LinearGradient(
                    colors: [.black,.green, .black, .blue, .black],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                WelcomeText(message: viewModel.welcomeText)
            }.gesture(DragGesture(minimumDistance: 20.0, coordinateSpace: .global).onEnded { value in
                let horizontalAmount = value.translation.width
                let verticalAmount = value.translation.height
                viewModel.didSwipeView.send((horizontalAmount,verticalAmount))
            })
        default:
            LoginView(viewModel: viewModel, userData: $viewModel.userAuthData)
        }
    }
}
