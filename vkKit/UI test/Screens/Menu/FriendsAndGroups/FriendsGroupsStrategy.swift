//
//  FriendsGroupsStrategy.swift
//  UI test
//
//  Created by Nail Safin on 16.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation


enum ItemsFG: String {

    case friends = "friends.get"
    case groups = "groups.get"

}



protocol FriendsGroupsStrategy: class {
   func getItems(async: @escaping ([Items]) -> Void)

}

final class FriendsStrategy: FriendsGroupsStrategy {

    func getItems(async: @escaping ([Items]) -> Void) {
        VKApi().getFriendGrouplist(requestType: .friends) { result in
            switch result {
            case .success(let friends):
                async(friends)
            case .failure(let err):
                print ("GOT ERROR \(err)")
            }
        }
    }
    

    
    
}

class GroupsStrategy: FriendsGroupsStrategy {
 
    func getItems(async: @escaping ([Items]) -> Void) {
        VKApi().getFriendGrouplist(requestType: .groups) { result in
            switch result {
            case .success(let groups):
                 async(groups)
            case .failure(let err):
                print ("GOT ERROR \(err)")
            }
        }
    }
    
    
}

