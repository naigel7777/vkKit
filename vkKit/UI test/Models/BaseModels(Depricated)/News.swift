

import Foundation

struct News
{
    
    
    var userName: String
    var imagePath: [String]
    var textNews: String
    var publicDate: String
    var avatar: String
    
    init(username: String, avatar: String, imagePath: [String], textNews: String, publicDate: String)
    {
        
        self.userName = username
        self.avatar = avatar
        self.imagePath = imagePath
        self.textNews = textNews
        self.publicDate = publicDate
    }

}
