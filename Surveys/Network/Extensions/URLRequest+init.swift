//
//  URLRequest+init.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

extension URLRequest {
    init(endpoint: APIServiceType) {

        let url = endpoint.baseURL
            .appendingPathComponent(endpoint.endpoint.path)
            .appendingQueryParameters(endpoint.parameters)

        self.init(url: url)
        httpMethod = endpoint.endpoint.method.rawValue

        endpoint.headers.forEach {
            addValue($0.value, forHTTPHeaderField: $0.key)
        }

        if endpoint.endpoint.method == .post || endpoint.endpoint.method == .put {
            let jsonData = try? JSONSerialization.data(withJSONObject: endpoint.parameters)
            httpBody = jsonData
        }
    }
}
