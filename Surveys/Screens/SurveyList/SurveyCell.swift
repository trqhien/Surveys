//
//  SurveyCell.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import TinyConstraints
import Kingfisher

final class SurveyCell: UITableViewCell, CellReusable {

    private let coverImage = UIImageView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }

    private let titleLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let descriptionLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private lazy var takeSurveyButton = UIButton().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Take the survey", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .watermelon
        $0.layer.cornerRadius = Constants.takeSurveyButtonSize.height / 2
        $0.addTarget(self, action: #selector(takeSurveyButtonTapped(_:)), for: .touchUpInside)
        $0.isHidden = true
    }

    var takeSurvey: (() -> Void)!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        coverImage.image = nil
    }

    func cancelDownload() {
        coverImage.kf.cancelDownloadTask()
    }

    func configure(_ survey: Survey) {
        descriptionLabel.text = survey.description
        titleLabel.text = survey.title
        takeSurveyButton.isHidden = false

        let url = URL(string: survey.highResCoverImageURLString)
        coverImage.kf.setImage(
            with: url,
            options: [.processor(OverlayImageProcessor(overlay: .black, fraction: 0.6))],
            completionHandler: { [weak self] result in
                switch result {
                case .failure:
                    self?.coverImage.image = UIImage(named: "placeholder-cover")
                default:
                    break
                }
            })
    }

    private func addSubviews() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(takeSurveyButton)

        coverImage.edgesToSuperview()
        titleLabel.center(in: contentView, offset: CGPoint(x: 0, y: -150))
        titleLabel.horizontalToSuperview(insets: Constants.horizontalEdgeInsets)

        descriptionLabel.centerX(to: contentView)
        descriptionLabel.topToBottom(of: titleLabel, offset: 23)
        descriptionLabel.horizontalToSuperview(insets: Constants.horizontalEdgeInsets)

        takeSurveyButton.size(Constants.takeSurveyButtonSize)
        takeSurveyButton.center(in: contentView, offset: CGPoint(x: 0, y: 150))
    }

    @objc private func takeSurveyButtonTapped(_ sender: UIButton) {
        takeSurvey()
    }
}

private extension SurveyCell {
    struct Constants {
        static let takeSurveyButtonSize = CGSize(width: 200, height: 60)
        static let horizontalEdgeInsets = TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
