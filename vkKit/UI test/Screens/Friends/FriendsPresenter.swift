//
//  FriendsPresenter.swift
//  UI test
//
//  Created by Nail Safin on 03.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import RealmSwift

protocol FriendsPresenter {
    func viewDidLoad2()
    func refreshData()
    func searchFriends(name: String)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getSectionIndexTitles() -> [String]?
    func getTitleForSection(section: Int) -> String?
    func getModelAtIndex(indexPath: IndexPath) -> RealmFriends?
}

class FriendsPresenterImplementation {
    
    var vkApi: VKApi
    var database: FriendSource
    let errorParser = VKapiErrorParser()
    var friendSection = [Section<RealmFriends>]()
    var friends: Results<RealmFriends>!
    var token: NotificationToken?
    weak var vc: UIViewController?
    var customRefreshControl = UIRefreshControl()
    private weak var view: FriendsControllerView?
    
    init(database: FriendSource, view: FriendsControllerView) {
        vkApi = VKApi()
        self.database = database
        self.view = view
    }
    
    func addRefreshConrol()
      {
          customRefreshControl.attributedTitle = NSAttributedString(string: "Обновление")
          customRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        self.view?.addsubview(crc: customRefreshControl)
      }
      
    @objc func refreshTable()
    {
        vkApi.getFriendlist(token: Session.shared.token, userID: Session.shared.userid) { result in
            switch result {
            case .success(let users):
                self.database.addAllFriends(friends: users)
            case .failure(let err):
                self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQUEST")
                print ("GOT ERROR \(err)")
            }

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            self.customRefreshControl.endRefreshing()
        }
    }
      
    private func getFriendFromRealm() {
        do {
        self.friends = try database.getFriends()
        self.makeSortedSection()
        self.view?.updateTable()
        }
        catch { print(error)}
        }
    
    private func vkApiRequest(){
        vkApi.getFriendlist(token: Session.shared.token, userID: Session.shared.userid) { result in
            switch result {
            case .success(let users):
                self.database.addAllFriends(friends: users)
            case .failure(let err):
                self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQUEST")
                print ("GOT ERROR \(err)")
            }
            
        }
    }
    
    private func showFriends() {
        do {
            friends = try database.getFriends()
            token = friends?.observe { [weak self] results in
                switch results {
                case .error(let error): print(error)
                case .initial: self?.view?.updateTable()
                case .update:
                    self?.getFriendFromRealm()
                    self?.makeSortedSection()
                    DispatchQueue.main.async {
                        
                        self?.view?.updateTable()
                    }
                }
            }
        } catch {
            print (error)
        }
    }
     private func makeSortedSection() {
        let friendsDictionary = Dictionary.init(grouping: friends) { $0.surName.prefix(1) }
               friendSection = friendsDictionary.map { Section(title: String($0.key), item: $0.value) }
               friendSection.sort {$0.title < $1.title}
    }
    
}
extension FriendsPresenterImplementation: FriendsPresenter {
    
    func numberOfSections() -> Int {
        return friendSection.count
    }
        func numberOfRowsInSection(section: Int) -> Int {
        return friendSection[section].item.count
    }
   
    func getModelAtIndex(indexPath: IndexPath) -> RealmFriends? {
        return friendSection[indexPath.section].item[indexPath.row]
    }
   
    func getSectionIndexTitles() -> [String]? {
        return friendSection.map { $0.title }
    }
    
    func getTitleForSection(section: Int) -> String? {
        return friendSection[section].title
    }
    
    func searchFriends(name:String) {
       do {
        self.friends = name.isEmpty ? try database.getFriends() : try database.searchFriend(name: name)
            
        let groupedFriends = Dictionary(grouping: friends) { $0.surName.prefix(1) }
              
               friendSection = groupedFriends.map { Section(title: String($0.key), item: $0.value) }
               friendSection.sort { $0.title < $1.title }
               self.view?.updateTable()
           } catch {
               print(error)
           }
    }
    func viewDidLoad2() {
        
      
        showFriends()
        
        addRefreshConrol()
    }
    func refreshData() {
         getFriendFromRealm()
         vkApiRequest()
    }
}
