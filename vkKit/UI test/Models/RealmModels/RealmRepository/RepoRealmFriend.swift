//
//  UserRepositoryRealm.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift
protocol FriendSource {
    func addFriend(id: Int, username: String, surname: String, avatarPath: String, onlineStatus: Int, deactivated: String)
    func addAllFriends(friends:[ItemFriend])
    func getFriend(id: Int) -> RealmFriends?
    func getFriends() throws -> Results<RealmFriends>
    func searchFriend(name: String) throws -> Results<RealmFriends>
}
class RepositoryRealmFriend: FriendSource {
    func addFriend (id: Int, username: String, surname: String, avatarPath: String, onlineStatus: Int, deactivated: String)  {
        let realm = try! Realm()
        let newUser = RealmFriends()
        newUser.id = id
        newUser.userName = username
        newUser.surName = surname
        newUser.avatarPath = avatarPath
        newUser.isOnline = onlineStatus
        newUser.deActivated = deactivated
        try! realm.write {
            realm.add(newUser)
        }
    }
    
    func addAllFriends(friends:[ItemFriend]){
        var allfriends = [RealmFriends]()
        friends.forEach { friend in
            let userRealm = RealmFriends()
            userRealm.id = friend.id
            userRealm.userName = friend.firstName
            userRealm.surName = friend.lastName
            userRealm.avatarPath = friend.photo50
            userRealm.isOnline = friend.online
            userRealm.deActivated = friend.deactivated
            allfriends.append(userRealm)
        }
        let realm = try! Realm()
        do{
            try realm.write {
                realm.add(allfriends, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func getFriend(id: Int) -> RealmFriends? {
        
        let realm = try! Realm()
        return realm.objects(RealmFriends.self).filter("id == %@", id).first
        
    }
    
    func getFriends() throws -> Results<RealmFriends> {
        do{
            let realm = try Realm()
            return realm.objects(RealmFriends.self).filter("deActivated == nil")
        } catch {
            throw error
        }
    }
    
    func searchFriend(name: String) throws -> Results<RealmFriends> {
        do {
            let realm = try Realm()
            return realm.objects(RealmFriends.self).filter("userName CONTAINS[c] %@",name)
        } catch {
            throw error
        }
    }
    
}
