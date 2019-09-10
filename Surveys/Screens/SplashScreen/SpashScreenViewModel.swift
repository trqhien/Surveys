//
//  SpashScreenViewModel.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

final class SplashScreenViewModel {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func authenticate(userName: String, password: String, completion: @escaping (NetworkResult<AuthenticationResult>) -> Void) {
        networkManager.request(endpoint: .authenticate(username: userName, password: password), type: AuthenticationResult.self, completion: completion)
    }
}
