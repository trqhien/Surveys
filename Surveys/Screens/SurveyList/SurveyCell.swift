//
//  SurveyCell.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import TinyConstraints

final class SurveyCell: UITableViewCell, CellReusable {

    private let coverImage = UIImageView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
    }

    private let titleLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    private let descriptionLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
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
    }

    func configure(_ survey: Survey) {
        descriptionLabel.text = survey.description
        titleLabel.text = survey.title
    }

    private func addSubviews() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        coverImage.edgesToSuperview()
        titleLabel.center(in: contentView, offset: CGPoint(x: 0, y: -20))
        descriptionLabel.center(in: contentView, offset: CGPoint(x: 0, y: 20))
    }
}
