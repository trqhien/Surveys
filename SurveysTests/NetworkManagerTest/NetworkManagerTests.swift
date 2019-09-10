//
//  NetworkManagerTests.swift
//  SurveysTests
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import XCTest
@testable import Surveys

class NetworkManagerTests: XCTestCase {

    let getSurveyListAPI = APIService.getSurveyList(page: 1, surveysPerPage: 2, accessToken: "accessToken")

    func testPerformNetworkTask_noData_shouldReturn_emptyResult() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertEqual(result, NetworkResult.failure(.emptyResult))
            }
        }
    }

    func testPerformNetworkTask_noResponse_shouldReturn_noHttpResponse() {
        let mockURLSession = MockURLSession(data: Data([0, 1]), response: nil, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertEqual(result, NetworkResult.failure(.noHttpResponse))
            }
        }
    }

    func testPerformNetworkTask_statusCodeIsNot2xx_shouldReturn_requestFailed() {
        let mockURLSession = MockURLSession(data: Data([0, 1]), response: httpResponse301, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertEqual(result, NetworkResult.failure(.requestFailed(httpResponse301)))
            }
        }
    }

    func testPerformNetworkTask_shouldReturn_success() {
        let mockURLSession = MockURLSession(data: surveyListMock, response: httpResponse200, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
            switch result {
            case .success(let surveys):
                XCTAssertEqual(surveys.count, 2)

                XCTAssertEqual(surveys[0].id, "d5de6a8f8f5f1cfe51bc")
                XCTAssertEqual(surveys[0].title, "Scarlett Bangkok")
                XCTAssertEqual(surveys[0].description, "We'd love ot hear from you!")
                XCTAssertEqual(surveys[0].coverImageURLString, "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_")
                XCTAssertEqual(surveys[0].highResCoverImageURLString, "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")

                XCTAssertEqual(surveys[1].id, "ed1d4f0ff19a56073a14")
                XCTAssertEqual(surveys[1].title, "ibis Bangkok Riverside")
                XCTAssertEqual(surveys[1].description, "We'd love to hear from you!")
                XCTAssertEqual(surveys[1].coverImageURLString, "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_")
                XCTAssertEqual(surveys[1].highResCoverImageURLString, "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_l")
            default:
                XCTFail()
            }
        }
    }

    func testPerformNetworkTask_missingId_shouldReturn_decodingFailed() {
        let mockURLSession = MockURLSession(data: surveyListMockWithoutID, response: httpResponse200, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        XCTAssertThrowsError(try surveyListMockWithoutID.decoded() as [Survey], "", { error in
            networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
                switch result {
                case .success:
                    XCTFail()
                case .failure:
                    XCTAssertEqual(result, NetworkResult.failure(.decodingFailed(error)))
                }
            }
        })
    }

    func testPerformNetworkTask_missingDescription_shouldReturn_decodingFailed() {
        let mockURLSession = MockURLSession(data: surveyListMockWithoutDescription, response: httpResponse200, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        XCTAssertThrowsError(try surveyListMockWithoutDescription.decoded() as [Survey], "", { error in
            networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
                switch result {
                case .success:
                    XCTFail()
                case .failure:
                    XCTAssertEqual(result, NetworkResult.failure(.decodingFailed(error)))
                }
            }
        })
    }

    func testPerformNetworkTask_missingTitle_shouldReturn_decodingFailed() {
        let mockURLSession = MockURLSession(data: surveyListMockWithoutTitle, response: httpResponse200, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        XCTAssertThrowsError(try surveyListMockWithoutTitle.decoded() as [Survey], "", { error in
            networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
                switch result {
                case .success:
                    XCTFail()
                case .failure:
                    XCTAssertEqual(result, NetworkResult.failure(.decodingFailed(error)))
                }
            }
        })
    }

    func testPerformNetworkTask_missingCoverImage_shouldReturn_decodingFailed() {
        let mockURLSession = MockURLSession(data: surveyListMockWithoutCoverImage, response: httpResponse200, error: nil)
        let networkManager = NetworkManager(session: mockURLSession)

        XCTAssertThrowsError(try surveyListMockWithoutCoverImage.decoded() as [Survey], "", { error in
            networkManager.request(endpoint: getSurveyListAPI, type: [Survey].self) { result in
                switch result {
                case .success:
                    XCTFail()
                case .failure:
                    XCTAssertEqual(result, NetworkResult.failure(.decodingFailed(error)))
                }
            }
        })
    }
}
