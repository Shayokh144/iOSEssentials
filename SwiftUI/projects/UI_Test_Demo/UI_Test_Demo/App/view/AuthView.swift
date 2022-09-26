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
                WelcomeText(message: "Nice to see you here...\n\nIn the dark side of the moon!")
            }
        default:
            LoginView(viewModel: viewModel, userData: $viewModel.userAuthData)
        }
    }
}
