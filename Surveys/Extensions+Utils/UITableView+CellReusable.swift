//
//  UITableView+CellReusable.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit

protocol CellReusable: Identifiable {
    static var nib: UINib? { get }
}

extension CellReusable {
    static var nib: UINib? { return nil }
}

typealias TableViewCellResuable = CellReusable & UITableViewCell

extension UITableView {
    func register<T: TableViewCellResuable>(_: T.Type) {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        } else {
            register(T.self, forCellReuseIdentifier: T.identifier)
        }
    }

    func dequeueReusableCell<T: TableViewCellResuable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
