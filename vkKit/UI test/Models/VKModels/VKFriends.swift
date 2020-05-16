//
//  VKFriends.swift
//  UI test
//
//  Created by Nail Safin on 20.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Item
struct ItemFriend: Codable, ResultItem {
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String
    let online: Int
    let deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case online
        case deactivated
    }
}


