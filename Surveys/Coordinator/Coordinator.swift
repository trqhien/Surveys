//
//  Coordinator.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/9/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
