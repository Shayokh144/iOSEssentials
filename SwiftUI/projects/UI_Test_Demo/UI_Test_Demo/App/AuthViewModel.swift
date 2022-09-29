//
//  LoginViewModel.swift
//  UI_Test_Demo
//
//  Created by Taher on 23/9/22.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {

    @Published var userAuthData: UserAuthData = UserAuthData(userName: "", password: "")
    @Published var authState: AuthState = .initial
    @Published var welcomeText: String = "Welcome"

    var  didTapLoginButton = PassthroughSubject<Void, Never>()
    var  didSwipeView = PassthroughSubject<(Double, Double), Never>()

    private var disposables = Set<AnyCancellable>()
    
    init() {
        didTapLoginButton.sink { [weak self] _ in
            self?.authState = .checking
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                if self?.isLoginDataCorrect() ?? false {
                    self?.authState = .succeed
                    self?.welcomeText = "Nice to see you here...\n\nIn the dark side of the moon!"
                } else {
                    self?.authState = .failed
                }
            }

        }.store(in: &disposables)

        didSwipeView.sink { [weak self] data in
            let (horizontalAmount, verticalAmount) = data
            if abs(horizontalAmount) > abs(verticalAmount) {
                if horizontalAmount < 0 {
                    self?.welcomeText = "LEFT SWIPE"
                } else {
                    self?.welcomeText = "RIGHT SWIPE"
                }
            } else {
                if verticalAmount < 0 {
                    self?.welcomeText = "UP SWIPE"
                } else {
                    self?.welcomeText = "DOWN SWIPE"
                }
            }
        }
        .store(in: &disposables)
    }

    private func isLoginDataCorrect() -> Bool {
        if self.userAuthData.userName == "abc" && self.userAuthData.password == "xyz" {
            return true
        }
        return false
    }
}
