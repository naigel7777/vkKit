//
//  CollectionViewExt.swift
//  UI test
//
//  Created by Nail Safin on 07.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func create<A: CellProtocol>(cell: A.Type, at index: IndexPath) -> A {
        return self.dequeueReusableCell(withReuseIdentifier: cell.name, for: index) as! A
    }

    func register<A: CellProtocol>(classCell: A.Type) {
        self.register(classCell.self, forCellWithReuseIdentifier: classCell.name)
    }
}
