//
//  URLSession+loadData.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

extension URLSession: URLSessionType {
    func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping URLSessionCompletionHandler
        ) -> URLSessionDataTask {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            queue.async { completionHandler(data, urlResponse, error) }
        }
        task.resume()
        return task
    }
}
