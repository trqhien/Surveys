//
//  InlineConfigurable.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Foundation

protocol InlineConfigurable {}

extension InlineConfigurable {
    func configure(_ configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}

extension NSObject: InlineConfigurable {}
