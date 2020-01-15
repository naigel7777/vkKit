//
//  VKApi.swift
//  vkKit
//
//  Created by Nail Safin on 15.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//


import UIKit
import WebKit
import Alamofire

class VKApi
{
    let vkURL = "https://api.vk.com/method/"
    let apiVersion = "5.103"
    let searchType = "Music"
    
    func getFriendlist(token: String,userID: String)
    {
        let requestUrl = vkURL + "friends.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "order": "name",
                      "fields": "city,domain",
                     "user_id": userID]
        
        Alamofire.request(requestUrl,
                          method: .post,
            parameters: params).responseString(completionHandler: {(response) in
                print(response.value)
            })
        
    }
    
    func getGroupList(token: String,userID: String)
    {
        let requestUrl = vkURL + "groups.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "extended": "1",
                      "count": "5",
                     "user_id": userID]
        
        Alamofire.request(requestUrl,
                          method: .post,
            parameters: params).responseString(completionHandler: {(response) in
                print(response.value)
            })

        
    }
    
    func getPhoto(token: String,userID: String)
    {
        let requestUrl = vkURL + "photos.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "album_id":"profile",
                      "extended": "1",
                      "count": "5",
                     "owner_id": userID]
        
        Alamofire.request(requestUrl,
                          method: .post,
            parameters: params).responseString(completionHandler: {(response) in
                print(response.value)
            })

        
    }
    
    func searchGroup(token: String,userID: String)
       {
           let requestUrl = vkURL + "groups.search"
           let params = ["access_token": token,
                         "v": apiVersion,
                         "q": searchType,
                         "offset": "3",
                         "count": "3",
                        "owner_id": userID]
           
           Alamofire.request(requestUrl,
                             method: .post,
               parameters: params).responseString(completionHandler: {(response) in
                   print(response.value)
               })

           
       }
}
