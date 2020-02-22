//
//  VKCommonResponse.swift
//  UI test
//
//  Created by Nail Safin on 27.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation

struct VKCommonResponse<T: Decodable>: Decodable {
    var response: VKCommonResponseArray<T>
}

struct VKCommonResponseArray <T:Decodable>: Decodable {
    var count: Int
    var items: [T]
}
