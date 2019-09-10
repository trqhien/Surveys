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

    weak var coordinator: RootCoordinator?

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
            $0.showsHorizontalScrollIndicator = false
            $0.register(SurveyCell.self)
        }

    private lazy var reloadButton = UIButton(type: .system)
        .configure {
            $0.setImage(UIImage(named: "icon-reload")?.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.frame = CGRect(origin: .zero, size: Constants.barButtonSize)
            $0.addTarget(self, action: #selector(reloadButtonTapped(_:)), for: .touchUpInside)
        }

    private let menuButton = UIBarButtonItem(
        image: UIImage(named: "icon-hamburger-menu")?.withRenderingMode(.alwaysOriginal),
        style: .plain,
        target: nil,
        action: nil
    )
        .configure { $0.isEnabled = false }

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

        setUpNavigationItems()
        fetchSurveyList()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
    }

    private func setUpNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: reloadButton)
        navigationItem.rightBarButtonItem = menuButton
    }

    private func realoadData() {
        tableView.reloadData()
        if viewModel.numberOfSurvey > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: false)
        }
        pageIndicator.reload()
        pageIndicator.focus(at: 0)
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(pageIndicator)

        if #available(iOS 11.0, *) {
            tableView.edges(to: view.safeAreaLayoutGuide)
        } else {
            tableView.edges(to: view.layoutMarginsGuide)
        }

        pageIndicator.right(to: view, offset: -10)
        pageIndicator.centerY(to: tableView)
        pageIndicator.heightToSuperview(multiplier: 0.6)
        pageIndicator.width(14)
    }

    @objc private func reloadButtonTapped(_ sender: UIBarButtonItem) {
        fetchSurveyList()
    }

    private func fetchSurveyList() {
        startReloadButtonstartAnimation()
        viewModel.getSurveyList(page: 1) { [weak self] result in
            guard let self = self else { return }

            self.stopReloadButtonAnimation()

            switch result {
            case .success(let surveys):
                if surveys.isEmpty {
                    self.tableView.setEmptyView(title: "Nothing's here", message: "You currently don't have any survey.")
                } else {
                    self.tableView.restore()
                }

                self.realoadData()
            case .failure(let error):
                // TODO: We can show a more user-friendly and general (Please try again later, We cannot fetch you data, etc) message here instead of just showing the exact error message
                self.tableView.setEmptyView(title: "Something's wrong", message: error.localizedDescription)
            }
        }
    }

    private func startReloadButtonstartAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = .infinity

        navigationItem.leftBarButtonItem?.isEnabled = false
        reloadButton.layer.add(rotationAnimation, forKey: "reloadButtonRotation")
    }

    private func stopReloadButtonAnimation() {
        navigationItem.leftBarButtonItem?.isEnabled = true
        reloadButton.layer.removeAnimation(forKey: "reloadButtonRotation")
    }
}

extension SurveyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSurvey
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SurveyCell
        let survey = viewModel.survey(at: indexPath.row)
        cell.takeSurvey = { [weak self] in
            self?.coordinator?.takeSurvey(survey)
        }
        cell.configure(survey)
        return cell
    }
}

extension SurveyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

extension SurveyListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard
            let indexPaths = tableView.indexPathsForVisibleRows,
            indexPaths.count == 1,
            let indexPath = indexPaths.first
            else { return }

        pageIndicator.focus(at: indexPath.row)

    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        pageIndicator.focus(at: 0)
    }
}

extension SurveyListViewController: PageIndicatorViewDataSource {
    func numberOfItems(in pageIndicatorView: PageIndicatorView) -> Int {
        return viewModel.numberOfSurvey
    }
}

private extension SurveyListViewController {
    struct Constants {
        static let barButtonSize = CGSize(width: 34, height: 34)
    }
}

