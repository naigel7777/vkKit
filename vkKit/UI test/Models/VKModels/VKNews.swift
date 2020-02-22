//
//  VKNews.swift
//  UI test
//
//  Created by Nail Safin on 18.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - VKNews


// MARK: - Response

struct VKNews  {
    var items: [NewsItem] = []
    var profiles: [Profile] = []
    var groups: [NewsGroup] = []
//    let nextFrom: String
    
    init(_ json: JSON) {
        
        
        json["response"]["groups"].arrayValue.forEach { (item) in
            groups.append(NewsGroup(item))
        }
        
        json["response"]["items"].arrayValue.forEach { (item) in
            items.append(NewsItem(item))
        }
        
        json["response"]["profiles"].arrayValue.forEach { (item) in
            profiles.append(Profile(item))
        }
    }

    func convert() -> [News] {
        var array: [News] = []
        
        items.forEach { (item) in
            
            let fullname: String
            let avatar: String
            let imagePath: [String]
            if item.sourceID > 0 {
                let owner = profiles.first(where: { $0.id == item.sourceID })
                fullname = (owner?.firstName ?? "") + " " + (owner?.lastName ?? "")
                avatar = owner?.photo50 ?? ""
//                let image = items.map { () -> T in
//                    <#code#>
//                }
                imagePath  = []
                
            } else {
                let group = groups.first(where: { $0.id == item.sourceID })
                fullname = group?.name ?? ""
                avatar = group?.photo50 ?? ""
                imagePath  = []
            }
            
         
            array.append(News(username: fullname,
                              avatar: avatar,
                              imagePath: imagePath,
                              textNews: item.text,
                              publicDate: String(item.date)))
        }
        
        
        return array
        
    }

}

// MARK: - Item
struct NewsItem {
    let sourceID, date: Int
    let text: String
    var attachments: [Attachment] = []

//    let comments: Comments
//    let likes: Likes
//    let reposts: Reposts
//    let views: Views

    init(_ json: JSON) {
        
        sourceID = json["source_id"].intValue
        date = json["date"].intValue
        text = json["text"].stringValue
        json["attachments"].arrayValue.forEach { (item) in
            attachments.append(Attachment(item))
        }
        
    }


}

// MARK: - Attachment
struct Attachment {
    let type: String
    let photo: Photo?
//    let video: VideoNews?
    init(_ json: JSON) {
        
        type = json["type"].stringValue
        photo = Photo(json["photo"])
    
        
    }

    
}

// MARK: - Photo
struct Photo {
    let id: Int
    var sizes: [SizeNews] = []

    init(_ json: JSON) {
        
        id = json["id"].intValue
       
        json["sizes"].arrayValue.forEach { (item) in
            sizes.append(SizeNews(item))
        }
       
        
    }

    
    

}

// MARK: - Size
struct SizeNews {
    let type: SizeType?
    let url: String
    let width, height: Int
   

    init(_ json: JSON) {
        
        type = SizeType(rawValue: json["type"].stringValue)
        url = json["url"].stringValue
        width = json["width"].intValue
        height = json["height"].intValue
        
    }

}

enum SizeType: String {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case x = "x"
    case y = "y"
    case z = "z"
}



// MARK: - Video
//struct VideoNews: Codable {
//    let accessKey: String
//    let canComment, canLike, canRepost, canSubscribe: Int
//    let canAddToFaves, canAdd, comments, date: Int
//    let videoDescription: String
//    let duration: Int
//    let image: [SizeNews]
//    let id, ownerID: Int
//    let title: String
//    let isFavorite: Int
//    let trackCode: String
//    let type: AttachmentType
//    let views: Int
//    let localViews: Int?
//    let platform: String?
//    let width, height: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case accessKey = "access_key"
//        case canComment = "can_comment"
//        case canLike = "can_like"
//        case canRepost = "can_repost"
//        case canSubscribe = "can_subscribe"
//        case canAddToFaves = "can_add_to_faves"
//        case canAdd = "can_add"
//        case comments, date
//        case videoDescription = "description"
//        case duration, image, id
//        case ownerID = "owner_id"
//        case title
//        case isFavorite = "is_favorite"
//        case trackCode = "track_code"
//        case type, views
//        case localViews = "local_views"
//        case platform, width, height
//    }
//}




// MARK: - Profile
struct Profile {
    let id: Int
    let firstName, lastName: String
    let photo50: String

    init(_ json: JSON) {
        
        id = json["id"].intValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        photo50 = json["photo_50"].stringValue
        
    }

   
    
}
// MARK: - Group
struct NewsGroup {
    let id: Int
    let name: String
    let photo50: String
    
    init(_ json: JSON) {
        
        id = json["id"].intValue
        name = json["name"].stringValue
        photo50 = json["photo_50"].stringValue
        
    }

    
  
}

