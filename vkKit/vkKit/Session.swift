//
//  Session.swift
//  vkKit
//
//  Created by Nail Safin on 15.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit
class Session
{
        static let shared = Session()
    private init () {}
    
    var token = ""
    var userid = ""
}
