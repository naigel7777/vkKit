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
    
    let mainView: ContainerView = {
        return $0
    }(ContainerView())
    

    
    
    //MARK: - Init
    override func loadView() {
        view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
       
   
        
       
        
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    
    
    //MARK: - Handlers
    
   
  
            
       
   
    

    

 
}
