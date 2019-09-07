//
//  SurveyListViewController.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit
import TinyConstraints

final class SurveyListViewController: UIViewController {

    private let viewModel: SurveyListViewModel

    private lazy var tableView = UITableView()
        .configure {
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 150
            $0.separatorColor = .lightGray
            $0.separatorInset = .zero
            $0.separatorStyle = .singleLine
            $0.isPagingEnabled = true
            $0.dataSource = self
            $0.delegate = self
            $0.allowsSelection = false
            $0.tableFooterView = UIView(frame: .zero)
            $0.showsVerticalScrollIndicator = false
            $0.register(SurveyCell.self)

    }

    private lazy var pageIndicator = PageIndicatorView()
        .configure {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.dataSource = self
        }

    init(viewModel: SurveyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()

        viewModel.getSurveyList(page: 1) { [weak self] result in
            switch result {
            case .success:
                self?.realoadData()
            case .failure:
                break
            }
        }
    }

    private func realoadData() {
        tableView.reloadData()
        pageIndicator.reload()
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(pageIndicator)

        tableView.edgesToSuperview()

        pageIndicator.right(to: view, offset: -10)
        pageIndicator.centerY(to: tableView)
        pageIndicator.heightToSuperview(multiplier: 0.6)
        pageIndicator.width(14)
    }
}

extension SurveyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSurvey
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SurveyCell
        let survey = viewModel.survey(at: indexPath.row)
        cell.configure(survey)
        return cell
    }
}

extension SurveyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

extension SurveyListViewController: PageIndicatorViewDataSource {
    func numberOfItems(in pageIndicatorView: PageIndicatorView) -> Int {
        return viewModel.numberOfSurvey
    }
}

