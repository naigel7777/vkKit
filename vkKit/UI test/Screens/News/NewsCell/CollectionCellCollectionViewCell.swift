//
//  CollectionCellCollectionViewCell.swift
//  UI test
//
//  Created by Nail Safin on 15.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit

class CollectionCellCollectionViewCell: UICollectionViewCell {


    
    @IBOutlet weak var image1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
}
