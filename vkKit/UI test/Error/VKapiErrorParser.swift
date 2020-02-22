//
//  VKapiErrorParser.swift
//  UI test
//
//  Created by Nail Safin on 28.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import Foundation
import UIKit
class VKapiErrorParser {
   
   
    
    func showErrorAlert(_ vc: UIViewController?, errorMessage: String) {
        let alter = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){ _ in
//            vc?.performSegue(withIdentifier: "FriendUnwind", sender: nil)
        }
        alter.addAction(action)
        if let vc = vc {
            vc.present(alter, animated: true)
        }
       
    }
}
