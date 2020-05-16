//
//  SettingsController.swift
//  UI test
//
//  Created by Nail Safin on 29.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
    //MARK: - Propites
    
   
    
    var centerController: UIViewController!
    var transInteraction: UIPercentDrivenInteractiveTransition?
    
    let mainView: ContainerView = {
        return $0
    }(ContainerView())
    
    let profileView: ProfilePhotoController = ProfilePhotoController()
    
    private var vkApi = VKApi()
    var name: String = ""
    var profileInfo: VKProfileInfo? = nil
    
    var userPhoto = [ItemPhoto]()
    var wallPhoto = [ItemPhoto]()
    //MARK: - Init
    override func loadView() {
        super.loadView()
        view = mainView
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    addGestureRecogniser()
    mainView.menuList.tapTableCell = didSelectMenuOption(menuOption:)
        promiseRequest()
       
        
       
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        mainView.showMenuController(shouldExpand: false)
        switch menuOption {
            
        case .profile:
            mainView.infoLabel.text = "press button Profile"
           profileView.profileInfo2 = profileInfo
            profileView.userPhotos = userPhoto
            profileView.wallPhotos = wallPhoto
            self.navigationController?.present(profileView, animated: true, completion: {

            })
            presentedViewController?.navigationController?.isNavigationBarHidden = false

            
        case .friends:
            mainView.infoLabel.text = "press button Settings"
            mainView.headLabel.text = menuOption.description
            navigationController?.present(FriendsGroupsVC(type: .friends), animated: true)
            presentedViewController?.navigationController?.isNavigationBarHidden = false
            
            
        case .groups:
            mainView.infoLabel.text = "press button Notification"
            
            mainView.headLabel.text = menuOption.description
            navigationController?.present(FriendsGroupsVC(type: .groups), animated: true)
            presentedViewController?.navigationController?.isNavigationBarHidden = false
            
        case .exit:
            
            mainView.infoLabel.text = "press button Exit"
            mainView.backgroundColor = .purple
            mainView.headLabel.text = menuOption.description
            
        }
    }
    
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }
    
    
    
    //MARK: - Handlers
    func promiseRequest() {
        let promise = vkApi.getProfileInfo(token: Session.shared.token, ownerID: Session.shared.userid)
        
        promise.done { (info) in
            self.profileInfo = info
            self.name = info.response.firstName
        }.catch { (error) in
            print(error)
        }
        
        vkApi.getPhoto(token: Session.shared.token, ownerID: Session.shared.userid) { (photos) in
            self.userPhoto = photos
        }
        vkApi.getPhotoWall(token: Session.shared.token, ownerID: Session.shared.userid) { (photo) in
            self.wallPhoto = photo
        }
        
    }
    
   func addGestureRecogniser() {
          let edgeRecognizer = UITapGestureRecognizer(target: self, action: #selector(edgeRecognize(_:)))
          
    mainView.mainView.addGestureRecognizer(edgeRecognizer)
      }
    @objc func edgeRecognize(_ gesture: UITapGestureRecognizer) {
        if !mainView.isExpanded {
            mainView.showMenuController(shouldExpand: mainView.isExpanded)
        }
    }
    
      func navigationController(_ navigationController: UINavigationController,
                                interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
          return transInteraction
      }
  
            
       
   
    

    

 
}
