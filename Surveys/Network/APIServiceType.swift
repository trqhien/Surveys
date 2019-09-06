//
//  APIServiceType.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

protocol APIServiceType {
    var baseURL: URL { get }
    var endpoint: Endpoint { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
}
