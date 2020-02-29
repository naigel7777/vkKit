//
//  RepoRealmNews.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift

class RepositoryRealmNews  {
    func addNews (id: Int, newsname: String, imagePath: String, user: RealmFriends, publicdate: String, textNews: String, avatar: String)  {
        let realm = try! Realm()
        let newNews = RealmNews()
        newNews.id = id
        newNews.newsName = newsname
//        newNews.imagePath = imagePath
        newNews.user.append(user)
        newNews.publicDate = publicdate
        newNews.textNews = textNews
        newNews.avatar = avatar
        try! realm.write {
            realm.add(newNews)
        }
    }
    
    func getAllNews() throws -> Results<RealmNews> {
        do {
            let realm = try Realm()
            return realm.objects(RealmNews.self)
        } catch {
            throw error
        }
        
    }
    

    
}
