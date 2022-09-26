//
//  UI_Test_DemoApp.swift
//  UI_Test_Demo
//
//  Created by Taher on 23/9/22.
//

import SwiftUI

@main
struct UI_Test_DemoApp: App {

    var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            AuthView(viewModel: viewModel)
        }
    }
}
