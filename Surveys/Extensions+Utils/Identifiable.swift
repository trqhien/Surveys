//
//  Identifiable.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }

    var id: String {
        return Self.identifier
    }
}
