//
//  VKApi.swift
//  UI test
//
//  Created by Nail Safin on 20.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import PromiseKit


enum ServerError: Error {
    case badRequest
    case notReacheble
}

class VKApi
{
    let vkURL = "https://api.vk.com/method/"
    let apiVersion = "5.103"
    let errPars = VKapiErrorParser()
    weak var vc: UIViewController?
    typealias Out = Swift.Result
    
    init(_ viewController: UIViewController? = nil) {
        vc = viewController
    }
    
    func sendRequest<T: Decodable>(url:String,
                                   method: HTTPMethod = .get,
                                   params: Parameters,
                                   completion: @escaping (Out<[T], Error>) -> () ) {
        
        AF.request(url,
                          method: method,
                          parameters: params).responseData { (result) in
                            guard let data = result.value else {
                                completion(.failure(ServerError.badRequest))
                                return
                            }
                            do {
                                let result = try JSONDecoder().decode(VKCommonResponse<T>.self, from: data)
                                completion(.success(result.response.items))
                            } catch {
                                completion(.failure(ServerError.notReacheble))
                            }
        }
    }
    
    
    func getFriendlist(token: String = Session.shared.token, userID: String = Session.shared.userid, completion: @escaping (Out<[ItemFriend], Error>) -> ())
    {
        let requestUrl = vkURL + "friends.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "order": "name",
                      "fields": "city,domain,photo_50",
                      "user_id": userID]
        sendRequest(url: requestUrl, params: params) {completion($0) }
    }
   
    
    func getGroupList(token: String = Session.shared.token, userID: String = Session.shared.userid, completion: @escaping (Out<[ItemGroup], Error>) -> Void)
    {
        let requestUrl = vkURL + "groups.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "extended": "1",
                      "filter":"groups",
                      "count": "20",
                     "user_id": userID]
         sendRequest(url: requestUrl, params: params) {completion($0) }

            }
    
    func getFriendGrouplist(token: String = Session.shared.token, userID: String = Session.shared.userid, requestType: ItemsFG, completion: @escaping (Out<[Items], Error>) -> ())
    {
        let requestUrl = vkURL + requestType.rawValue
        let params = ["access_token": token,
                      "v": apiVersion,
                      "order": "name",
                      "extended": "1",
                      "filter":"groups",
                      "fields": "photo_50, photo_100, photo_200",
                      "user_id": userID]
        sendRequest(url: requestUrl, params: params) {completion($0) }
    }

    func getGroupListFuture(token: String,userID: String) -> Promise<[ItemGroup]> {
        let requestUrl = vkURL + "groups.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "extended": "1",
                      "filter":"groups",
                      "count": "30",
                      "user_id": userID]
        return Promise  { resolver in
            AF.request(requestUrl,
                       method: .get,
                       parameters: params).responseJSON { response in
                        switch response.result {
                        case let .success(json):
                            var groups = Array<ItemGroup>()
                            let jsonGroups = (JSON(json))["response"]["items"].arrayValue
                            jsonGroups.forEach { item in
                                groups.append(ItemGroup(item))
                            }
 
                            resolver.fulfill(groups)
                        case let .failure(error):
                            resolver.reject(error)
                        }
            }
        }
        
        
    }
    
    
    func getPhoto(token: String,ownerID: String, async: @escaping ([ItemPhoto]) -> ())
    {
        
        let requestUrl = vkURL + "photos.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "album_id":"profile",
                      "extended": "0",
                      "rev": "0",
                     "owner_id": ownerID]
        
        AF.request(requestUrl,
                          method: .post,
                          parameters: params).responseData {(response) in
               guard let data = response.value else {
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(VKPhoto.self, from: data)
                        async(response.response.items)
                    } catch {
                        self.errPars.showErrorAlert(self.vc, errorMessage: "Отсутсвуют фото")
                        print(error)
                    }
                }
            }

    func getPhotoWall(token: String,ownerID: String, async: @escaping ([ItemPhoto]) -> ())
    {
        
        let requestUrl = vkURL + "photos.getUserPhotos"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "count":"50",
                      "extended": "0",
                      "sort": "0",
                     "user_id": ownerID]
        
        AF.request(requestUrl,
                   method: .get,
                          parameters: params).responseData {(response) in
               guard let data = response.value else {
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(VKPhoto.self, from: data)
                        async(response.response.items)
                    } catch {
                        self.errPars.showErrorAlert(self.vc, errorMessage: "Отсутсвуют фото")
                        print(error)
                    }
                }
            }

        func getNews(token: String, async: @escaping ([News]) -> ())
         {
             
             let requestUrl = vkURL + "newsfeed.get"
             let params = ["access_token": token,
                           "v": apiVersion,
                           "filters":"post",
                           "return_banned": "0",
                           "count": "10"]
             
             AF.request(requestUrl,
                               method: .get,
                               parameters: params).responseJSON {(response) in
                                switch response.result {
                               
                                case let .success(value):
                                    async(VKNews(JSON(value)).convert)
                                case let .failure(error):
                                    print(error)
                                }
                                
                     }
                 }
    
    func getProfileInfo(token: String,ownerID: String) -> Promise<VKProfileInfo>{
        let requestUrl = vkURL + "account.getProfileInfo"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "owner_id": ownerID]
        return Promise { resolver in
            AF.request(requestUrl,
                       method: .get,
                       parameters: params).responseData {(response) in
                        guard let data = response.value else { return }
                        do {
                       
                            let resp = try JSONDecoder().decode(VKProfileInfo.self, from: data)
                            resolver.fulfill(resp)
                    
                        } catch {
                            resolver.reject(error)
                        }
            }
            
        }
    }
    
    func getNextNews(token: String, nextFrom: String, async: @escaping ([News], String) -> ())
    {
        
        let requestUrl = vkURL + "newsfeed.get"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "filters":"post",
                      "return_banned": "0",
                      "start_from":nextFrom,
                      "count": "13"]
        
        DispatchQueue.global(qos: .background).async {
            AF.request(requestUrl,
                       method: .get,
                       parameters: params).responseJSON { response in
                        switch response.result {
                            
                        case let .success(value):
                            let nextFrom = VKNews(JSON(value)).nextFrom
                            async(VKNews(JSON(value)).convert, nextFrom)
                        case let .failure(error):
                            print(error)
                        }
                        
            }
        }
        
    }
    
    func searchGroup(token: String, searchText: String, completion:@escaping (Out<[ItemGroup], Error>) -> ())
    {
        let requestUrl = vkURL + "groups.search"
        let params = ["access_token": token,
                      "v": apiVersion,
                      "q": searchText,
                      "offset": "3",
                      "count": "10"]
        
       sendRequest(url: requestUrl, params: params) {completion($0) }
//        AF.request(requestUrl,
//                          method: .post,
//                          parameters: params).responseData {(response) in
//                            guard let data = response.value else {
//                                return
//                            }
//                            do {
//                                let response = try JSONDecoder().decode(VKGroupList.self, from: data)
//                                let groups = response.toGroup()
//                                completion(groups)
//                            } catch {
//
//                                print(error)
//                            }
//        }
    }
    
    
}
