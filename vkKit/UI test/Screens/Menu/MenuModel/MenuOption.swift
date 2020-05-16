//
//  MenuOption.swift
//  UI test
//
//  Created by Nail Safin on 29.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit

enum MenuOption: Int, CaseIterable, CustomStringConvertible {
      
    case profile
    case friends
    case groups
    case exit
    
    var description: String {
        switch self {
        case .profile: return "Профиль"
        case .friends: return "Друзья"
        case .groups: return "Группы"
        case .exit: return "Exit"
            
        }
    }
    var image: UIImage {
        switch self {
        case .profile: return UIImage(named: "profile") ?? UIImage()
        case .friends: return UIImage(named: "Settings") ?? UIImage()
        case .groups: return UIImage(named: "notification") ?? UIImage()
        case .exit: return UIImage(named: "exit") ?? UIImage()
            
        }
    }
    
}
