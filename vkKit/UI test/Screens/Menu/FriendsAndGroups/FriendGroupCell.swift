//
//  FriendGroupCell.swift
//  UI test
//
//  Created by Nail Safin on 13.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import Kingfisher

final class FriendGroupCell: UITableViewCell, CellProtocol {
    static var name: String {
        "FriendGroupCell"
    }
    
    let avatar: UIImageView = {
        $0.image = UIImage(named: "123")
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        return $0
    }(UIImageView())
    
    let name: UILabel = {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.textAlignment = .left
        $0.text = "Some Test Label"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: frame.width, height: 110)
    }
    
    private func initViews() {
        backgroundColor = .white
        
        let avatarSide: CGFloat = 100
        avatar.pin(to: self).topLeft(5).size(avatarSide)
        name.pin(to: self).after(of: avatar, aligned: .center).marginLeft(10).right(10).sizeToFit(.width)
        self.pin.height(avatarSide + 10)
    }
    
    func bind(model: Items) {
        self.name.text = model.name ?? "\(model.firstName ?? "" ) \(model.lastName ?? "")"
        let url = URL(string: model.photo50)
        self.avatar.kf.setImage(with: url)
    }

}

