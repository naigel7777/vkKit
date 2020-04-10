//
//  RealmFriends.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift

class FriendsSections: Object {
    @objc dynamic var nameSection: String = ""
    let elements = List<RealmFriends>()
}

class RealmFriends: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var userName: String = ""
    @objc dynamic var surName:String = ""
    @objc dynamic var avatarPath:String = ""
    @objc dynamic var isOnline:Int = 0
    @objc dynamic var deActivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "first_name"
        case surName = "last_name"
        case avatarPath = "photo_50"
        case isOnline
        case deActivated
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> ItemFriend {
        return ItemFriend(id: id, firstName: userName, lastName: surName, photo50: avatarPath, online: isOnline, deactivated: deActivated)
    }
    
}



