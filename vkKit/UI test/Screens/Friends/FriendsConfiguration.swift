//
//  FriendsConfiguration.swift
//  UI test
//
//  Created by Nail Safin on 03.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
protocol FriendsConfigurator {
    func configure(view: FriendsController)
}

class FriendsConfiguratorImplementation: FriendsConfigurator {
    func configure(view: FriendsController) {
        view.presenter = FriendsPresenterImplementation(database: RepositoryRealmFriend(), view: view)
        
    }
}

