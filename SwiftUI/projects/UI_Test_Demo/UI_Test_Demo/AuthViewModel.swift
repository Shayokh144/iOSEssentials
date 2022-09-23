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
}
