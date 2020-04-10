//
//  ContainerView.swift
//  UI test
//
//  Created by Nail Safin on 27.03.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import PinLayout

class ContainerView: UIView {
    
    //MARK: - Propites
    
    
    private var isExpanded: Bool = true
    
    let topMenuController: UIView = {
        $0.backgroundColor = .darkGray
        return $0
    }(UIView())
    
    let menuBtn: UIButton = {
        $0.setImage(UIImage(named: "menu"), for: .normal)
        $0.tintColor = .red
        return $0
    }(UIButton())
    
    let mainView: UIView = {
        $0.backgroundColor = .green
        return $0
    }(UIView())
    
    let infoLabel: UILabel = {
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 36)
        return $0
    }(UILabel())
    
    let menuList: Menu = {
        $0.backgroundColor = .darkGray
        return $0
    }(Menu())
    
    
    //MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layouts()
    }
    
    //MARK: - Handlers
    func layouts() {
        self.backgroundColor = .darkGray
        menuList.pin(to: self).all(pin.safeArea)
        menuList.initViews()
        menuList.tapTableCell = didSelectMenuOption(menuOption:)
        
        mainView.pin(to: self).all(pin.safeArea)
        topMenuController.pin(to: mainView).horizontally().top().height(40)
        menuBtn.pin(to: topMenuController).size(topMenuController.frame.height).topLeft()
        menuBtn.addTarget(self, action: #selector(menuTap), for: .touchUpInside)
        infoLabel.pin(to: mainView).height(40).horizontally(40).vCenter()
    }
    
    @objc func menuTap() {
        
        showMenuController(shouldExpand: isExpanded)
        
    }
    func showMenuController(shouldExpand: Bool) {
        isExpanded.toggle()
        if shouldExpand {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.mainView.frame.origin.x = self.mainView.frame.width - 70
            })
        } else {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.mainView.frame.origin.x = 0
                            
            })
        }
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        showMenuController(shouldExpand: false)
        switch menuOption {
            
        case .Profile:
            infoLabel.text = "press button Profile"
            mainView.backgroundColor = .lightGray
        case .Settings:
            infoLabel.text = "press button Settings"
            mainView.backgroundColor = .red
            
        case .Notifications:
            infoLabel.text = "press button Notification"
            mainView.backgroundColor = .magenta
            
        case .Exit:
           
            infoLabel.text = "press button Exit"
            mainView.backgroundColor = .purple
            
        
        }
    }

}
