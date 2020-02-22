//
//  RegistrationController.swift
//  UI test
//
//  Created by Nail Safin on 06.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit
//import FirebaseAuth

class RegistrationController: UIViewController {
    
    
    @IBOutlet weak var newLogin: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    var err = VKapiErrorParser()
    
//    @IBAction func regButton(_ sender: Any) {
//        guard let email = newLogin.text,
//            let pass = newPassword.text else { return }
//        Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
//            print(result)
//            print(error)
//
//        }
//        
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
