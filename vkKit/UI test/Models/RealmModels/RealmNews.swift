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
    @objc dynamic var userName = ""
    let imagePath = List<String>()
    @objc dynamic var textNews = ""
    @objc dynamic var publicDate = ""
    @objc dynamic var avatar = ""
    
}
