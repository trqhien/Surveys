//
//  URL+appendingParameters.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

extension URL {
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL {
        guard
            !parameters.isEmpty,
            var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
            else { return self }

        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return urlComponents.url ?? self
    }
}
