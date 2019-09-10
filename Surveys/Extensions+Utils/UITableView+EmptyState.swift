//
//  UITableView+EmptyState.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import TinyConstraints

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))

        let titleLabel = UILabel()
            .configure {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.text = title
                $0.textAlignment = .center
                $0.numberOfLines = 0
                $0.font = UIFont.boldSystemFont(ofSize: 18)
            }

        let messageLabel = UILabel()
            .configure {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.text = message
                $0.textAlignment = .center
                $0.numberOfLines = 0
                $0.font = UIFont.systemFont(ofSize: 17)
            }

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        titleLabel.centerYToSuperview()
        titleLabel.horizontalToSuperview(insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))

        messageLabel.topToBottom(of: titleLabel, offset: 20)
        messageLabel.horizontalToSuperview(insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))

        backgroundView = emptyView
        separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
