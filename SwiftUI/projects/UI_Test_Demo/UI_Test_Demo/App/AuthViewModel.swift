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
            print("xyz user data : \(self?.userAuthData)")

        }.store(in: &disposables)

    }
}
