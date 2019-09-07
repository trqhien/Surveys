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
        $0.font = UIFont.boldSystemFont(ofSize: 30)//systemFont(ofSize: 20)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

        addSubviews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        coverImage.image = nil
        coverImage.kf.cancelDownloadTask()
    }

    func configure(_ survey: Survey) {
        descriptionLabel.text = survey.description
        titleLabel.text = survey.title

        let url = URL(string: survey.highResCoverImageURLString)
        coverImage.kf.setImage(
            with: url,
            options: [.processor(OverlayImageProcessor(overlay: .black, fraction: 0.6))],
            completionHandler: { [weak self] result in
                switch result {
                case .failure(let error):
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

        coverImage.edgesToSuperview()
        titleLabel.center(in: contentView, offset: CGPoint(x: 0, y: -150))
        titleLabel.horizontalToSuperview(insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        descriptionLabel.centerX(to: contentView)
        descriptionLabel.topToBottom(of: titleLabel, offset: 23)
        descriptionLabel.horizontalToSuperview(insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
}
