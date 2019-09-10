//
//  SurveyListMocks.swift
//  SurveysTests
//
//  Created by Hien Quang Tran on 9/10/19.
//  Copyright © 2019 Hien Quang Tran. All rights reserved.
//

let surveyListMock = """
    [
        {
            "id": "d5de6a8f8f5f1cfe51bc",
            "title": "Scarlett Bangkok",
            "description": "We'd love ot hear from you!",
            "access_code_prompt": null,
            "thank_email_above_threshold": null,
            "thank_email_below_threshold": null,
            "footer_content": null,
            "is_active": true,
            "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
            "cover_background_color": null,
            "type": "Restaurant",
            "created_at": "2017-01-23T14:48:12.991+07:00",
            "active_at": "2015-10-08T14:04:00.000+07:00",
            "inactive_at": null,
            "survey_version": 0,
            "short_url": "Scarlettbkk",
            "language_list": [
                "en"
            ],
            "default_language": "en",
            "tag_list": "Scarlett",
            "is_access_code_required": false,
            "is_access_code_valid_required": false,
            "access_code_validation": "",
            "theme": {
                "color_active": "#9B2828",
                "color_inactive": "#000000",
                "color_question": "#ffffff",
                "color_answer_normal": "#FFFFFF",
                "color_answer_inactive": "#FFFFFF"
            },
            "questions": []
        },
        {
            "id": "ed1d4f0ff19a56073a14",
            "title": "ibis Bangkok Riverside",
            "description": "We'd love to hear from you!",
            "access_code_prompt": null,
            "thank_email_above_threshold": null,
            "thank_email_below_threshold": null,
            "footer_content": null,
            "is_active": true,
            "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_",
            "cover_background_color": null,
            "type": "Hotel",
            "created_at": "2017-01-23T10:32:24.585+07:00",
            "active_at": "2016-01-22T11:12:00.000+07:00",
            "inactive_at": null,
            "survey_version": 0,
            "short_url": "ibis",
            "language_list": [
                "en"
            ],
            "default_language": "en",
            "tag_list": "ibis",
            "is_access_code_required": false,
            "is_access_code_valid_required": false,
            "access_code_validation": "",
            "theme": {
                "color_active": "#EE100C",
                "color_inactive": "#3A3A3A",
                "color_question": "#ffffff",
                "color_answer_normal": "#000000",
                "color_answer_inactive": "#FFFFFF"
            },
            "questions": []
        }
    ]
""".data(using: .utf8)!

let surveyListMockWithoutID = """
    [
        {
            "title": "Scarlett Bangkok",
            "description": "We'd love ot hear from you!",
            "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"
        }
    ]
""".data(using: .utf8)!

let surveyListMockWithoutDescription = """
    [
        {
            "id": "d5de6a8f8f5f1cfe51bc",
            "title": "Scarlett Bangkok",
            "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"
        }
    ]
""".data(using: .utf8)!

let surveyListMockWithoutTitle = """
    [
        {
            "id": "d5de6a8f8f5f1cfe51bc",
            "description": "We'd love ot hear from you!",
            "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"
        }
    ]
""".data(using: .utf8)!

let surveyListMockWithoutCoverImage = """
    [
        {
            "id": "d5de6a8f8f5f1cfe51bc",
            "title": "Scarlett Bangkok",
            "description": "We'd love ot hear from you!",
        }
    ]
""".data(using: .utf8)!

let surveyListMockWithoutIDds = """
    [
        {
            "id": "d5de6a8f8f5f1cfe51bc",
            "title": "Scarlett Bangkok",
            "description": "We'd love ot hear from you!",
            "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"
        }
    ]
""".data(using: .utf8)!

let emptySurveyListMock = """
    []
""".data(using: .utf8)!
