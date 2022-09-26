//
//  AuthButtonView.swift
//  UI_Test_Demo
//
//  Created by Taher on 26/9/22.
//

import SwiftUI

struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220.0, height: 50.0)
            .background(Color.green)
            .cornerRadius(7.0)
    }
}
