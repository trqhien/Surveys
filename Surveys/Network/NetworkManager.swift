//
//  NetworkManager.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Codextended

struct NetworkManager {
    private let session: URLSessionType
    private let queue: DispatchQueue

    init(session: URLSessionType = URLSession.shared, queue: DispatchQueue = .main) {
        self.session = session
        self.queue = queue
    }

    @discardableResult
    func request<T: Codable>(
        endpoint: APIService,
        type: T.Type,
        completion: @escaping (NetworkResult<T>) -> Void) -> URLSessionDataTask
    {
        let request = URLRequest(endpoint: endpoint)

        return session.loadData(with: request, queue: queue) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.underlyingError(error!)))
                return
            }

            guard let data = data else {
                completion(.failure(.emptyResult))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noHttpResponse))
                return
            }

            guard 200..<300 ~= response.statusCode else {
                completion(.failure(.requestFailed(response)))
                return
            }

            do {
                let result = try data.decoded() as T
                completion(.success(result))
            } catch let error {
                completion(.failure(.decodingFailed(error)))
            }
        }
    }
}
