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
   
    func getAllNews() -> [News]?
    func addLastNews (news: [News])
}

class RepositoryRealmNews: NewsRepository  {
    
    
    func addLastNews (news: [News])  {
        let realm = try! Realm()
        var lastNews = [RealmNews]()
        news.forEach { n in
            let newNews = RealmNews()
            newNews.userName = n.userName
           
            n.imageMax.forEach({ newNews.imageMax.append($0) })
  
            n.imageMin.forEach({ newNews.imageMin.append($0) })
            newNews.publicDate = n.publicDate
            newNews.textNews = n.textNews
            newNews.avatar = n.avatar
                   lastNews.append(newNews)
            
        }
       
        
        try! realm.write {
            realm.deleteAll()
            realm.add(lastNews)
        }
    }
    
    func getAllNews()  -> [News]? {
        do {
            let realm = try Realm()
            let resultRealm = realm.objects(RealmNews.self)
            var items = [News]()
            resultRealm.forEach { item in
                items.append(item.convert)
            }
            return items
        } catch {
            print(error)
        }
        return nil
    }
    

    
}
