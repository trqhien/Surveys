//
//  SurveyListViewModelTests.swift
//  SurveysTests
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import XCTest
@testable import Surveys

class SurveyListViewModelTests: XCTestCase {

    func testGetEmptySurveyList() {
        let mockURLSession = MockURLSession(data: emptySurveyListMock, response: httpResponse200, error: nil)
        let mockNetworkManager = NetworkManager(session: mockURLSession)
        let viewModel = SurveyListViewModel(networkManager: mockNetworkManager)

        viewModel.getSurveyList(page: 1, surveysPerpage: 10) { result in
            XCTAssertEqual(result, NetworkResult.success([]))
        }
    }

    func testGetSurveyList() {
        let mockURLSession = MockURLSession(data: surveyListMock, response: httpResponse200, error: nil)
        let mockNetworkManager = NetworkManager(session: mockURLSession)
        let viewModel = SurveyListViewModel(networkManager: mockNetworkManager)

        viewModel.getSurveyList(page: 1, surveysPerpage: 10) { result in
            switch result {
            case .success(let surveys):
                XCTAssertEqual(surveys.count, 2)
                XCTAssertEqual(surveys.count, viewModel.numberOfSurvey)

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
}
