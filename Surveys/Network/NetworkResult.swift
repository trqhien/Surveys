//
//  NetworkResult.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

enum NetworkResult<R> {
    case success(R)
    case failure(NetworkError)
}

enum NetworkError: Swift.Error {
    case underlyingError(Error)
    case emptyResult
    case noHttpResponse
    case decodingFailed(Error)
    case requestFailed(HTTPURLResponse)
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .underlyingError(let error):
            return error.localizedDescription
        case .emptyResult:
            return "Empty Result"
        case .noHttpResponse:
            return "No HTTP Not Found"
        case .decodingFailed(let error):
            return "Failed to decode. Error: \(error)"
        case .requestFailed(let response):
            return "HTTP request failed with `\(response.statusCode)`"
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}

extension NetworkResult: Equatable where R: Equatable {
    static func == (lhs: NetworkResult<R>, rhs: NetworkResult<R>) -> Bool {
        switch (lhs, rhs) {
        case (.success(let data1), .success(let data2)):
            return data1 == data2
        case (.failure(let error1), .failure(let error2)):
            return error1 == error2
        default:
            return false
        }
    }
}
