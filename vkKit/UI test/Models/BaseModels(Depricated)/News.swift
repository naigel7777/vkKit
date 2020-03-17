

import Foundation

struct News
{
    
    
    var userName: String
 
    var imageMin: [String]
    var imageMax: [String]
    var textNews: String
    var publicDate: Int
    var avatar: String
    
    init(username: String, avatar: String, imageMin: [String], imageMax: [String], textNews: String, publicDate: Int)
    {
        
        self.userName = username
        self.avatar = avatar
 
        self.imageMin = imageMin
        self.imageMax = imageMax
        self.textNews = textNews
        self.publicDate = publicDate
    }

}
