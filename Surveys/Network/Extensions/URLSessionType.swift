//
//  URLSessionType.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

protocol URLSessionType {
    typealias URLSessionCompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping URLSessionCompletionHandler
        ) -> URLSessionDataTask
}
