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
    let imageMin = List<String>()
    let imageMax = List<String>()
    @objc dynamic var textNews = ""
    @objc dynamic var publicDate = 0
    @objc dynamic var avatar = ""
    
    var convert: News {
       var iMax = [String]()
        self.imageMax.forEach { img in
            iMax.append(img)
        }
        var iMin = [String]()
        self.imageMin.forEach { (imm) in
            iMin.append(imm)
        }
        return News(username: self.userName,
                    avatar: self.avatar,
                    imageMin: iMin,
                    imageMax: iMax,
                    textNews: self.textNews,
                    publicDate: self.publicDate)
        
    }
    
    override class func primaryKey() -> String? {
           return "id"
       }
    
}
