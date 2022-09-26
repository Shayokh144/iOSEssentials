//
//  TextView.swift
//  UI_Test_Demo
//
//  Created by Taher on 26/9/22.
//

import SwiftUI

struct WelcomeText : View {
    var message: String!
    var body: some View {
        return Text(message)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UsernameTextField : View {

    @Binding var username: String
    @Binding var editingMode: Bool

    var body: some View {
        return TextField("", text: $username).placeholder(when: username.isEmpty) {
            Text("username").foregroundColor(.gray)
        }
        .accessibilityIdentifier("usernameTextFieldId")
        .padding()
        .foregroundColor(.black)
        .background(Colors.lightGreyColor)
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
        .accessibilityIdentifier("passwordSecureFieldId")
        .padding()
        .foregroundColor(.black)
        .background(Colors.lightGreyColor)
        .cornerRadius(5.0)
        .padding(.bottom, 20)
        .onTapGesture {
            if self.editingMode == false {
                self.editingMode = true
            }
        }
    }
}
