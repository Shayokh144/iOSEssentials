//
//  LoginViewModel.swift
//  UI_Test_Demo
//
//  Created by nimble on 23/9/22.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {

    @Published var userAuthData: UserAuthData = UserAuthData()
    @Published var isUserLoginSuccessful = false

    private var disposables = Set<AnyCancellable>()
    
    init() {

    }
}
