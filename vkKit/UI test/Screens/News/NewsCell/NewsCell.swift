//
//  NewsCell.swift
//  UI test
//
//  Created by Nail Safin on 12.12.2019.
//  Copyright © 2019 Nail Safin. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var postTime: UILabel!
    
  
    @IBOutlet weak var newsImage: UICollectionView!
    @IBOutlet weak var newsText: UILabel!
    var collection: [UIImage] = []
    
    override func awakeFromNib() {
        self.newsImage.register(UINib.init(nibName: "img", bundle: nil), forCellWithReuseIdentifier: "img")
       }

    
    func setup(item: News)
    {
      //  newsImage.register(CollectionCellCollectionViewCell.self, forCellWithReuseIdentifier: "img")
        newsText.text = item.textNews
        avatar.image = UIImage(named: item.avatar)
        postTime.text = item.publicDate
        userName.text = item.userName
        
//        for i in item.imagePath {
//            collection.append(UIImage(named: i) ?? UIImage())
//        }
//        newsImage.reloadData()
//    }
    
}

//extension NewsCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
//{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collection.count
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collection[indexPath.row].size
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as? CollectionCellCollectionViewCell
//            else
//            {
//                return UICollectionViewCell()
//            }
//        let someimg = collection[indexPath.row]
//        cell.image1.image = someimg
//        self.layoutIfNeeded()
//        self.setNeedsLayout()
//        return cell
//    }

}
