//
//  FriendsGroupsVM.swift
//  UI test
//
//  Created by Nail Safin on 13.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation

protocol FriendsGroupsAbstractVM: class {
    var reloadCallBack: () -> Void { get set }
    var items: [Items] { get set }
    func get() 
}




final class FriendsGroupsVM: FriendsGroupsAbstractVM {
    
    var reloadCallBack: () -> Void = { }
    private let strategy: FriendsGroupsStrategy
    var items: [Items] = [] {
        didSet {
            reloadCallBack()
        }
    }
    
    init(type: ItemsFG) {
        switch type {
        case .friends:
            self.strategy = FriendsStrategy()
        case .groups:
            self.strategy = GroupsStrategy()
        }
       
    }
    
    func get() {
        strategy.getItems { result in
            self.items = result
        }
    }
    
    
    
    
    
}
