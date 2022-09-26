//
//  LoginView.swift
//  UI_Test_Demo
//
//  Created by Taher on 26/9/22.
//

import SwiftUI

struct LoginView : View {

    var viewModel: AuthViewModel

    @Binding var userData: UserAuthData

    @State var editingMode: Bool = false

    var body: some View {

        ZStack {
            VStack {
                WelcomeText(message: "Welcome")
                UsernameTextField(username: $userData.userName, editingMode: $editingMode)
                PasswordSecureField(password: $userData.password, editingMode: $editingMode)
                if viewModel.authState == .failed {
                    Text("Username or password is wrong.Try again.")
                        .foregroundColor(.red).padding(.bottom, 20)
                }
                if viewModel.authState != .checking {
                    Button(action: {
                        viewModel.didTapLoginButton.send()
                    }) {
                        LoginButtonContent()
                    }.accessibilityIdentifier("loginButtonIdentifier")
                } else {
                    LoadingView().frame(height: 6.0, alignment: .center)
                }
            }
            .padding()
        }
        .offset(y: editingMode ? -40 : 0)
    }
}
