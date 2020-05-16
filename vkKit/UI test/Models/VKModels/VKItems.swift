//
//  VKItems.swift
//  UI test
//
//  Created by Nail Safin on 16.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit

protocol ResultItem {}


// MARK: - Item
struct Items: Codable {
    let id: Int
    let name: String?
    let firstName: String?
    let lastName: String?
    let photo50: String
    let photo100: String?
    let photo200: String?
    let online: Int?
 
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case online

    }
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.firstName = try? container.decode(String.self, forKey: .firstName)
        self.lastName = try? container.decode(String.self, forKey: .lastName)
        self.photo50 = try container.decode(String.self, forKey: .photo50)
        self.photo100 = try? container.decode(String.self, forKey: .photo100)
        self.photo200 = try? container.decode(String.self, forKey: .photo200)
        self.online = try? container.decode(Int.self, forKey: .online)
      
        
        
    }
}
