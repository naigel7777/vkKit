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
    
    
    var isExpanded: Bool = true
    
    let topMenuController: UIView = {
        $0.backgroundColor = .secondarySystemBackground
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
    
    let headLabel: UILabel = {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
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
        self.backgroundColor = .secondarySystemBackground
        menuList.pin(to: self).all(pin.safeArea)
        menuList.initViews()

        
        mainView.pin(to: self).all(pin.safeArea)
        topMenuController.pin(to: mainView).horizontally().top().height(40)
        headLabel.pin(to: topMenuController).height(topMenuController.frame.height).width(topMenuController.frame.width - 80).center()
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
    


}
