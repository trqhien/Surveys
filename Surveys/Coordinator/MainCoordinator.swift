//
//  MainCoordinator.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let surveyListViewModel = SurveyListViewModel()
        let surveyListViewController = SurveyListViewController(viewModel: surveyListViewModel)
        surveyListViewController.coordinator = self
        navigationController.pushViewController(surveyListViewController, animated: true)
    }
}
