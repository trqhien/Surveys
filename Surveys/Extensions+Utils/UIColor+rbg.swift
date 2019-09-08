//
//  UIColor+rbg.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/8/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import UIKit

extension UIColor {
    static func rbg(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(
            red: CGFloat(red)/CGFloat(255),
            green: CGFloat(green)/CGFloat(255),
            blue: CGFloat(blue)/CGFloat(255),
            alpha: alpha
        )
    }
}

extension UIColor {
    static let watermelon = UIColor.rbg(255, 74, 91)
}
