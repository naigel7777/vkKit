//
//  VKGroupList.swift
//  UI test
//
//  Created by Nail Safin on 20.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation

//// MARK: - VKGroupList
//struct VKGroupList: Codable {
//    let response: ResponseGroup
//}
//
//// MARK: - Response
//struct ResponseGroup: Codable {
//    let count: Int
//    let items: [ItemGroup]
//}

// MARK: - Item
struct ItemGroup: Codable {
    let id: Int
    let name: String
    let photo50: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo50 = "photo_50"
     
    }
}
//extension VKGroupList{
//    func toGroup() -> [Group]{
//       var groups = [Group]()
//        response.items.forEach { (ItemGroup) in
//            groups.append(Group(groupName: ItemGroup.name,
//                                 avatarPath: URL(string: ItemGroup.photo50)
//                                  ))
//        }
//        return groups
//    }
//}
