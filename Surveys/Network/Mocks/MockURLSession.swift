//
//  MockURLSession.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

struct MockURLSession: URLSessionType {
    private(set) var data: Data?
    private(set) var response: URLResponse?
    private(set) var error: Error?

    func loadData(with urlRequest: URLRequest, queue: DispatchQueue, completionHandler: @escaping MockURLSession.URLSessionCompletionHandler) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return URLSession.shared.dataTask(with: urlRequest) { _, _, _ in }
    }
}
