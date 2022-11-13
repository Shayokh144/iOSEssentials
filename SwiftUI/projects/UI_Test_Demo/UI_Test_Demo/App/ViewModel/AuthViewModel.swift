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
    var  didSwipeView = PassthroughSubject<CGSize, Never>()

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

        didSwipeView.sink { [weak self] translationData in
            let horizontalAmount = translationData.width
            let verticalAmount = translationData.height
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
        let param : [String : AnyHashable] = [
            "grant_type": "password",
            "email": "dev@nimblehq.co",
            "password": "12345678",
            "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
            "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        ]
        let url = URL(string: "https://survey-api.nimblehq.co/api/v1/oauth/token")
        var urlReq = URLRequest(url: url!, timeoutInterval: TimeInterval(300))
        urlReq.httpMethod = "POST"
        urlReq.httpBody = nil

        do {
            urlReq.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
        } catch let error {
            NSLog(error.localizedDescription)
        }
        URLSession.shared.dataTaskPublisher(for: urlReq)
            .tryMap { data, response -> Data in
                return data
            }
            .decode(type: LoginTokenApi.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        NSLog("ERROR: \(error)")
                    case .finished:
                        NSLog("Login token response finished")
                    }
                }, receiveValue: { data in
                    print(data)
                }
            )
            .store(in: &disposables)
        if self.userAuthData.userName == "abc" && self.userAuthData.password == "xyz" {
            return true
        }
        return false
    }
}
struct LoginTokenApi: Decodable {

    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case data
        case attributes
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let attributes = try data.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        accessToken = try attributes.decode(String.self, forKey: .accessToken)
        tokenType = try attributes.decode(String.self, forKey: .tokenType)
        expiresIn = try attributes.decode(Int.self, forKey: .expiresIn)
        refreshToken = try attributes.decode(String.self, forKey: .refreshToken)
        createdAt = try attributes.decode(Int.self, forKey: .createdAt)
    }
}
