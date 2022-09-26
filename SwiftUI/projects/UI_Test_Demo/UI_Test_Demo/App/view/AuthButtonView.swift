//
//  AuthButtonView.swift
//  UI_Test_Demo
//
//  Created by nimble on 26/9/22.
//

import SwiftUI

struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
