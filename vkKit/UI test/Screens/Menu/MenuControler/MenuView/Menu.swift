//
//  Menu.swift
//  UI test
//
//  Created by Nail Safin on 29.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import PinLayout
import UIKit

private let reuseidetifer = "MenuOptionCell"


class Menu: UIView {
    //MARK: - Propites
    var tableView : UITableView = UITableView()
    var tapTableCell: (MenuOption) -> Void = {_ in }
    
    
    //MARK: - Init
    
    
    
    //MARK: - Handlers
    
    func initViews() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseidetifer)
        tableView.backgroundColor = .darkGray
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.pin(to: self).all(pin.safeArea)

        
    }
    

}
extension Menu: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseidetifer, for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption.allCases[indexPath.row]
        cell.descriptionLabel.text = menuOption.description
        cell.iconImageView.image = menuOption.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
     tapTableCell(MenuOption.allCases[indexPath.row])
        

    }
    
   
}
