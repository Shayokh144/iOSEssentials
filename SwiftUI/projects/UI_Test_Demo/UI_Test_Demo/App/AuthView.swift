//
//  ContentView.swift
//  UI_Test_Demo
//
//  Created by Taher on 23/9/22.
//

import SwiftUI

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

let storedUsername = "a"
let storedPassword = "a"


struct AuthView: View {

    @ObservedObject var viewModel: AuthViewModel

    @State var isLoggedIn: Bool = false

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
            LoginView(viewModel: viewModel, isLoggedIn: $isLoggedIn, userData: $viewModel.userAuthData)
        }
    }
}

struct LoginView : View {

    var viewModel: AuthViewModel
    @Binding var isLoggedIn: Bool
    @Binding var userData: UserAuthData

    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false

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

struct WelcomeText : View {
    var message: String!
    var body: some View {
        return Text(message)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
        //change
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UsernameTextField : View {

    @Binding var username: String

    @Binding var editingMode: Bool

    var body: some View {
        return TextField("", text: $username).placeholder(when: username.isEmpty) {
            Text("username").foregroundColor(.gray)
        }
        .padding()
        .foregroundColor(.black)
        .background(lightGreyColor)
        .cornerRadius(5.0)
        .padding(.bottom, 20)
        .onTapGesture {
            if self.editingMode == false {
                self.editingMode = true
            }
        }
    }
}

struct PasswordSecureField : View {

    @Binding var password: String
    @Binding var editingMode: Bool

    var body: some View {
        return SecureField("", text: $password, onCommit: {
            self.editingMode = true
        })
        .placeholder(when: password.isEmpty) {
            Text("password").foregroundColor(.gray)
        }
        .padding()
        .foregroundColor(.black)
        .background(lightGreyColor)
        .cornerRadius(5.0)
        .padding(.bottom, 20)
        .onTapGesture {
            if self.editingMode == false {
                self.editingMode = true
            }
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
