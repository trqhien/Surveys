//
//  SurveyListViewModel.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class SurveyListViewModel: Identifiable {
    private let networkManager: NetworkManager

    private var fetchSurveyListTask: URLSessionDataTask?

    private let readWriteQueue = DispatchQueue(label: "\(SurveyListViewModel.identifier)-readWriteQueue", qos: .userInteractive, attributes: .concurrent)

    private var _surveys: [Survey] = []

    var numberOfSurvey: Int {
        var temp: Int!
        readWriteQueue.sync {
            temp = _surveys.count
        }

        return temp
    }

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getSurveyList(page: Int, surveysPerpage: Int = 20, completion: @escaping (NetworkResult<[Survey]>) -> Void) {

        guard fetchSurveyListTask == nil else { return }
        
        fetchSurveyListTask = networkManager.request(
            endpoint: .getSurveyList(page: page, surveysPerPage: surveysPerpage, accessToken: KeychainWrapper.accessToken ?? ""),
            type: [Survey].self,
            completion: { [weak self] result in
                self?.fetchSurveyListTask = nil
                
                switch result {
                case .success(let surveys):
                    self?.updateSurvey(surveys)
                case .failure:
                    break
                }

                completion(result)
            })
    }

    private func updateSurvey(_ newSurveys: [Survey]) {
        readWriteQueue.async(flags: .barrier) { [weak self] in
            self?._surveys = newSurveys
        }
    }

    func survey(at index: Int) -> Survey {
        var temp: Survey!
        readWriteQueue.sync {
            temp = _surveys[index]
        }

        return temp
    }
}
