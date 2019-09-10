//
//  SurveyViewController.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import TinyConstraints
import Kingfisher

final class SurveyViewController: UIViewController {

    private let coverImage = UIImageView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }

    private let titleLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let descriptionLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    init(survey: Survey) {
        super.init(nibName: nil, bundle: nil)
        configureUI(survey)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addSubviews()
    }

    private func configureUI(_ survey: Survey) {
        descriptionLabel.text = survey.description
        titleLabel.text = survey.title

        let url = URL(string: survey.highResCoverImageURLString)
        coverImage.kf.setImage(
            with: url,
            options: [.processor(OverlayImageProcessor(overlay: .black, fraction: 0.6))]
        )
    }

    private func addSubviews() {
        view.addSubview(coverImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.sendSubviewToBack(coverImage)

        coverImage.edgesToSuperview()

        titleLabel.horizontalToSuperview(insets: Constants.horizontalInsets)
        titleLabel.centerInSuperview()

        descriptionLabel.topToBottom(of: titleLabel, offset: 15)
        descriptionLabel.horizontalToSuperview(insets: Constants.horizontalInsets)
    }
}

private extension SurveyViewController {
    struct Constants {
        static let horizontalInsets = TinyEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
