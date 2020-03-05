//
//  RepoRealmNews.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift

protocol NewsRepository {
    func addNews (userName: String, imagePath: String, publicdate: String, textNews: String, avatar: String)
    func getAllNews() throws -> Results<RealmNews>
    func addLastNews (news: [News])
}

class RepositoryRealmNews: NewsRepository  {
    
    func addNews (userName: String, imagePath: String, publicdate: String, textNews: String, avatar: String)  {
        let realm = try! Realm()
        let newNews = RealmNews()
        newNews.userName = userName
        newNews.imagePath.append(imagePath)
        newNews.publicDate = publicdate
        newNews.textNews = textNews
        newNews.avatar = avatar
        try! realm.write {
            realm.add(newNews)
        }
    }
    
    func addLastNews (news: [News])  {
        let realm = try! Realm()
        var lastNews = [RealmNews]()
        news.forEach { news in
            let newNews = RealmNews()
            newNews.userName = news.userName
//            let image = news.imagePath
//            newNews.imagePath.append(image)
//            newNews.imagePath = news.imagePath
            newNews.publicDate = news.publicDate
            newNews.textNews = news.textNews
            newNews.avatar = news.avatar
                   lastNews.append(newNews)
            
        }
       
        
        try! realm.write {
            
            realm.add(lastNews)
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
