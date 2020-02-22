//
//  RepositoruRealmGroup.swift
//  UI test
//
//  Created by Nail Safin on 23.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import RealmSwift
protocol GroupRepository {
    func addGroup (id: Int, groupname: String, avatarPath: String)
    func addAllGroups(groups: [ItemGroup])
    func getGroupById(id: Int) -> RealmGroups?
    
}

class RepositoryRealmGroup: GroupRepository  {
    
    func addGroup (id: Int, groupname: String, avatarPath: String)  {
        let realm = try! Realm()
        let newGroup = RealmGroups()
        newGroup.id = id
        newGroup.groupName = groupname
        newGroup.avatarPath = avatarPath
        try! realm.write {
            realm.add(newGroup)
        }
    }
    
    func addAllGroups(groups: [ItemGroup]) {
        do {
            let realm = try! Realm()
            
            
            try realm.write() {
                var groupsToAdd = [RealmGroups]()
                groups.forEach { group in
                    let groupRealm = RealmGroups()
                    groupRealm.id = group.id
                    groupRealm.groupName = group.name
                    groupRealm.avatarPath = group.photo50
                    groupsToAdd.append(groupRealm)
                }
                realm.add(groupsToAdd, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func getGroupById(id: Int) -> RealmGroups? {
        let realm = try! Realm()
        return realm.objects(RealmGroups.self).filter("id == %@", id).first
    }
    
    func getAllGroups() throws -> Results<RealmGroups> {
        do {
            let realm = try Realm()
            return realm.objects(RealmGroups.self)
        } catch {
            throw error
        }
        
    }
    func searchGroups(name: String) throws -> Results<RealmGroups> {
        do {
            let realm = try Realm()
            return realm.objects(RealmGroups.self).filter("groupName CONTAINS[c] %@", name)
        } catch {
            throw error
        }
    }
    func deleteGroup(group: RealmGroups) {
        do{
            let realm = try Realm()
            try realm.write {
                realm.delete(group)
            }
        } catch {
            print(error)
        }
    }
}
