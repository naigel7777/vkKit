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
      
    case Profile
    case Settings
    case Notifications
    case Exit
    
    var description: String {
        switch self {
        case .Profile: return "Профиль"
        case .Settings: return "Settings"
        case .Notifications: return "Уведомления"
        case .Exit: return "Exit"
            
        }
    }
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "profile") ?? UIImage()
        case .Settings: return UIImage(named: "Settings") ?? UIImage()
        case .Notifications: return UIImage(named: "notification") ?? UIImage()
        case .Exit: return UIImage(named: "exit") ?? UIImage()
            
        }
    }
    
}
