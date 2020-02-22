//
//  GroupRealm.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift
class RealmGroups: Object {
    @objc dynamic var id = 0
    @objc dynamic var groupName = ""
    @objc dynamic var avatarPath = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photo50 = "photo_50"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    func toModel() -> ItemGroup {
        return ItemGroup(id: id, name: groupName, photo50: avatarPath)
    }
}
