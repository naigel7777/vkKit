//
//  MenuOptionCell.swift
//  UI test
//
//  Created by Nail Safin on 29.02.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import PinLayout

class MenuOptionCell: UITableViewCell {

    
    //MARK: - Propites
    
    let iconImageView: UIImageView = {
   
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = .darkGray
        
        return $0
    }(UIImageView())
    
    let descriptionLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
        
        
        
        //MARK: - Init
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .darkGray
        selectionStyle = .none
        let padding: CGFloat = 15
        let sizeIcon: CGFloat = 25
        iconImageView.pin(to: self).topLeft().margin(padding).size(sizeIcon)
        descriptionLabel.pin(to: self).after(of: iconImageView).marginLeft(padding).right().height(18).vCenter()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
