//
//  AuthModel.swift
//  UI_Test_Demo
//
//  Created by Taher on 23/9/22.
//

import Foundation
import SwiftUI

struct UserAuthData {
    var userName: String
    var password: String
}

enum AuthState {
    case initial
    case checking
    case failed
    case succeed
}

struct Colors {
    static let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    private init() {}
}
