//
//  ContentView.swift
//  UI_Test_Demo
//
//  Created by Taher on 23/9/22.
//

import SwiftUI

struct AuthView: View {

    @ObservedObject var viewModel: AuthViewModel
    @State var welcomeText: String = "Nice to see you here...\n\nIn the dark side of the moon!"

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
                WelcomeText(message: welcomeText)
            }.gesture(DragGesture(minimumDistance: 20.0, coordinateSpace: .global).onEnded { value in
                let horizontalAmount = value.translation.width
                let verticalAmount = value.translation.height
                if abs(horizontalAmount) > abs(verticalAmount) {
                    if horizontalAmount < 0 {
                        welcomeText = "LEFT SWIPE"
                    } else {
                        welcomeText = "RIGHT SWIPE"
                    }
                } else {
                    if verticalAmount < 0 {
                        welcomeText = "UP SWIPE"
                    } else {
                        welcomeText = "DOWN SWIPE"
                    }
                }
            })
        default:
            LoginView(viewModel: viewModel, userData: $viewModel.userAuthData)
        }
    }
}
