//
//  APIService.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation
import Keys
import SwiftKeychainWrapper

enum APIService {
    case authenticate(username: String, password: String)
    case getSurveyList(page: Int, surveysPerPage: Int, accessToken: String)
}

extension APIService: APIServiceType {
    var baseURL: URL {
        guard let url = URL(string: SurveysKeys().baseURL) else {
            preconditionFailure("FAILED to construct URL with \(SurveysKeys().baseURL)")
        }

        return url
    }

    var endpoint: Endpoint {
        switch self {
        case .authenticate:
            return .post(path: "/oauth/token")
        case .getSurveyList:
            return .get(path: "/surveys.json")
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
        case .getSurveyList(let surveyInfo):
            return [
                "page": surveyInfo.page,
                "per_page": surveyInfo.surveysPerPage,
                "access_token": surveyInfo.accessToken,
            ]
        }
    }
}
