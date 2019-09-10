//
//  MainCoordinator.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

final class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    let window: UIWindow

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        if KeychainWrapper.accessToken != nil {
            let surveyListViewModel = SurveyListViewModel()
            let surveyListViewController = SurveyListViewController(viewModel: surveyListViewModel)
            surveyListViewController.coordinator = self
            navigationController.pushViewController(surveyListViewController, animated: true)
            window.rootViewController = navigationController
        } else {
            let splashScreenViewModel = SplashScreenViewModel()
            let splashScreenViewController = SplashScreenViewController(viewModel: splashScreenViewModel)
            splashScreenViewController.coordinator = self
            window.rootViewController = splashScreenViewController
        }

        window.makeKeyAndVisible()
    }

    func takeSurvey(_ survey: Survey) {
        let surveyViewController = SurveyViewController(survey: survey)
        navigationController.pushViewController(surveyViewController, animated: true)
    }
}
