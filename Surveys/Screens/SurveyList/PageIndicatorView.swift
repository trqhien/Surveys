//
//  PageIndicatorView.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/7/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit

final class PageIndicatorView: UIView {
    weak var dataSource: PageIndicatorViewDataSource!

    private var views: [UIView] = []

    private(set) var currentIndex: Int! {
        didSet {
            if oldValue != nil && 0..<views.count ~= oldValue {
                views[oldValue].backgroundColor = .clear
            }

            views[currentIndex].backgroundColor = .white
        }
    }

    func reload() {
        let numberOfItems = dataSource.numberOfItems(in: self)

        guard numberOfItems > 0 else { return }

        addItems(numberOfItems: numberOfItems)
    }

    func focus(at index: Int) {
        currentIndex = index
    }

    private func addItems(numberOfItems: Int) {
        self.subviews.forEach { $0.removeFromSuperview() }

        views = (1...numberOfItems).map { _ -> UIView in
            let item = UIView()
            item.translatesAutoresizingMaskIntoConstraints = false
            item.size(CGSize(width: 10, height: 10))
            item.layer.cornerRadius = 5
            item.layer.borderWidth = 2
            item.layer.borderColor = UIColor.white.cgColor
            return item
        }

        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 5

        addSubview(stackView)
        stackView.edgesToSuperview()
    }
}

protocol PageIndicatorViewDataSource: class {
    func numberOfItems(in pageIndicatorView: PageIndicatorView) -> Int
}

extension PageIndicatorViewDataSource {
    func numberOfItems(in pageIndicatorView: PageIndicatorView) -> Int {
        return 0
    }
}
