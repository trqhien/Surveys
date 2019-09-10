//
//  SplashScreenViewController.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import TinyConstraints
import Keys
import SwiftKeychainWrapper

final class SplashScreenViewController: UIViewController {
    private let viewModel: SplashScreenViewModel

    weak var coordinator: RootCoordinator?

    private let activityIndicator = UIActivityIndicatorView()
        .configure {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.hidesWhenStopped = true
            $0.style = .gray
        }

    private let descriptionLabel = UILabel()
        .configure {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Authorizing"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }

    init(viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        authenticate()
    }

    private func addSubviews() {
        view.addSubview(activityIndicator)
        view.addSubview(descriptionLabel)

        activityIndicator.centerInSuperview()

        descriptionLabel.topToBottom(of: activityIndicator, offset: 12)
        descriptionLabel.centerXToSuperview()
        descriptionLabel.horizontalToSuperview(insets: Constants.horizontalInsets)
    }

    private func authenticate() {
        activityIndicator.startAnimating()

        viewModel.authenticate(userName: SurveysKeys().username, password: SurveysKeys().password) { [weak self] result in
            self?.activityIndicator.stopAnimating()

            switch result {
            case .success(let auth):
                KeychainWrapper.auth.set(auth.accessToken, forKey: KeychainWrapper.Key.accessToken)
                self?.descriptionLabel.text = auth.accessToken
                self?.coordinator?.start()
            case .failure(let error):
                self?.descriptionLabel.text = error.localizedDescription
            }
        }
    }
}

private extension SplashScreenViewController {
    struct Constants {
        static let horizontalInsets = TinyEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
