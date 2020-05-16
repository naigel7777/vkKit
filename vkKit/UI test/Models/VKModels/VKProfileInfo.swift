//
//  VKProfileInfo.swift
//  UI test
//
//  Created by Nail Safin on 05.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import SwiftyJSON
// MARK: - VKProfileInfo
struct VKProfileInfo: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let firstName, lastName, bdate: String
    let bdateVisibility: Int
    let city, country: City
    let homeTown, phone: String
    let relation: Int
    let screenName: String
    let sex: Int
    let status: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case bdate
        case bdateVisibility = "bdate_visibility"
        case city, country
        case homeTown = "home_town"
        case phone, relation
        case screenName = "screen_name"
        case sex, status
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
