//
//  Survey.swift
//  Surveys
//
//  Created by Hien Quang Tran on 9/6/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

import Codextended
import DeepDiff

struct Survey: Codable {
    let id: String
    let title: String
    let description: String
    let coverImageURLString: String

    var highResCoverImageURLString: String {
        return "\(coverImageURLString)l"
    }

    init(from decoder: Decoder) throws {
        id = try decoder.decode("id")
        title = try decoder.decode("title")
        description = try decoder.decode("description")
        coverImageURLString = try decoder.decode("cover_image_url")
    }
}

extension Survey: Equatable {
    static func == (lhs: Survey, rhs: Survey) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Survey: DiffAware {
    var diffId: String {
        return id
    }

    static func compareContent(_ a: Survey, _ b: Survey) -> Bool {
        return a.id == b.id
    }
}
