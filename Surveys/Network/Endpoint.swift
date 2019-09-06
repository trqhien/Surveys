//
//  Endpoint.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

enum Endpoint {
    case get(path: String)
    case post(path: String)
    case put(path: String)
    case delete(path: String)

    var path: String {
        switch self {
        case let .get(path),
             let .post(path),
             let .put(path),
             let .delete(path):
            return path
        }
    }

    var method: HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .delete:
            return HTTPMethod.delete
        }
    }
}
