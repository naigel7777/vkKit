//
//  VKGroupSearch.swift
//  UI test
//
//  Created by Nail Safin on 20.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//


import Foundation

// MARK: - VKGroupSearch
struct VKGroupSearch: Codable {
    let response: ResponseSearch
}

// MARK: - Response
struct ResponseSearch: Codable {
    let count: Int
    let items: [ItemSearch]
}

// MARK: - Item
struct ItemSearch: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
