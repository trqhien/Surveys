//
//  Keychain.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import SwiftKeychainWrapper

extension KeychainWrapper {
    struct Key {
        static let accessToken = "accessToken"
    }
    
    static let auth = KeychainWrapper(serviceName: "surveys-auth")

    static var accessToken: String? {
        return KeychainWrapper.auth.string(forKey: Key.accessToken)
    }
}
