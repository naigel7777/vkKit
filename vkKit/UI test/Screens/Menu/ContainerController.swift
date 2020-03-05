//
//  ContainerController.swift
//  UI test
//
//  Created by Nail Safin on 29.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit

class ContainerController: UIViewController {
    //MARK: - Propites
    var menuController: MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    
    //MARK: - Handlers
    
    func configureHomeController() {
        let homeController = MainTabBarController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            
        }
    }
    func showMenuController(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 70
            },
                           completion: nil)
        } else {

            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            self.centerController.view.frame.origin.x = 0
            }) {(_) in
                guard let menuoption = menuOption else {return}
                self.didSelectMenuOption(menuOption: menuoption)
                
            }
        }
        animatedStatusBar()
    }
    
    func animatedStatusBar() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        
                        self.setNeedsStatusBarAppearanceUpdate()
        },
                       completion: nil)
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
            
        case .Profile:
            print("press button Profile")
        case .Settings:
            print("press buton Settings")
        case .Notifications:
            print("Button Notification")
        case .Exit:
            print("Press Button Exit")
        
        }
    }
    
    //MARK: -
}
extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded, menuOption: menuOption)
    }
    

    
    
}
