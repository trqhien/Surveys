//
//  APIService.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

enum APIService {
    case authenticate(username: String, password: String)
}

// TODO: put https://nimble-survey-api.herokuapp.com into cocoapod keys
extension APIService: APIServiceType {
    var baseURL: URL {
        guard let url = URL(string: "https://nimble-survey-api.herokuapp.com") else {
            preconditionFailure("FAILED to construct URL with https://nimble-survey-api.herokuapp.com")
        }

        return url
    }

    var endpoint: Endpoint {
        switch self {
        case .authenticate:
            return .post(path: "/oauth/token")
        }
    }

    var headers: [String : String] {
        return ["application/json": "Content-Type"]
    }

    var parameters: [String: Any] {
        switch self {
        case .authenticate(let authenticationInfo):
            return [
                "grant_type": "password",
                "username": authenticationInfo.username,
                "password": authenticationInfo.password,
            ]
        }
    }
}
