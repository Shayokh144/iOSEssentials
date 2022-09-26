//
//  LoginViewModel.swift
//  UI_Test_Demo
//
//  Created by nimble on 23/9/22.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {

    @Published var userAuthData: UserAuthData = UserAuthData(userName: "", password: "")
    @Published var authState: AuthState = .initial

    var  didTapLoginButton = PassthroughSubject<Void, Never>()

    private var disposables = Set<AnyCancellable>()
    
    init() {

        didTapLoginButton.sink { [weak self] _ in
            self?.authState = .checking
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                if self?.isLoginDataCorrect() ?? false {
                    self?.authState = .succeed
                } else {
                    self?.authState = .failed
                }
            }

        }.store(in: &disposables)

    }

    private func isLoginDataCorrect() -> Bool {
        if self.userAuthData.userName == "abc" && self.userAuthData.password == "xyz" {
            return true
        }
        return false
    }
}
