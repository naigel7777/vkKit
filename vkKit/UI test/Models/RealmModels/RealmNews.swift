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
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var userName = ""
    let imagePath = List<String>()
    @objc dynamic var textNews = ""
    @objc dynamic var publicDate = ""
    @objc dynamic var avatar = ""
    
    var convert: News {
       var items = [String]()
        self.imagePath.forEach { img in
            items.append(img)
        }
        return News(username: self.userName,
                    avatar: self.avatar,
                    imagePath: items,
                    textNews: self.textNews,
                    publicDate: self.publicDate)
        
    }
    
    override class func primaryKey() -> String? {
           return "id"
       }
    
}
