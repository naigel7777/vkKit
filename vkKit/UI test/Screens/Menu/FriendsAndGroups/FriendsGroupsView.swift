//
//  FriendsGroupsView.swift
//  UI test
//
//  Created by Nail Safin on 13.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import PinLayout

final class FriendsGroupsView: UIView {

    let rowsFG : UITableView = {
        $0.backgroundColor = .white
        $0.register(classCell: FriendGroupCell.self)
        return $0
    }(UITableView())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
    }
    
    private func initViews() {
        backgroundColor = .brown
        rowsFG.pin(to: self).all(pin.safeArea)
    }
    
}


