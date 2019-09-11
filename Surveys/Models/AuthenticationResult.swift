//
//  AuthenticationResult.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Codextended

struct AuthenticationResult: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int

    init(from decoder: Decoder) throws {
        accessToken = try decoder.decode("access_token")
        tokenType = try decoder.decode("token_type")
        expiresIn = try decoder.decode("expires_in")
        createdAt = try decoder.decode("created_at")
    }
}

// TODO: I can improve the flow a little bit by auto reauthenticate when ever the token expires. However, I don't really know how the value `createdAt` is calculated. But once I do, I can use that to figure out whether or not my access token has expired
