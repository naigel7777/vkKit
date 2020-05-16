//
//  VKPhoto.swift
//  UI test
//
//  Created by Nail Safin on 20.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation

// MARK: - VKPhoto
struct VKPhoto: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [ItemPhoto]
}

// MARK: - Item
struct ItemPhoto: Codable {
    let id, albumID, ownerID: Int
    let sizes: [Size]
    let text: String
    let date: Int
 //   let postID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes, text, date
 //       case postID = "post_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let type: String
    let url: String
    let width, height: Int
}
