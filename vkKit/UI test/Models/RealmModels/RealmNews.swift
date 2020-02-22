//
//  RealmNews.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNews: Object{
    @objc dynamic var id = 0
    @objc dynamic var newsName = ""
    let user = List<RealmFriends>()
    @objc dynamic var imagePath = ""
    @objc dynamic var textNews = ""
    @objc dynamic var publicDate = ""
    @objc dynamic var avatar = ""
    let group = List<RealmGroups>()
}
