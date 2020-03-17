//
//  NewsCell.swift
//  UI test
//
//  Created by Nail Safin on 12.12.2019.
//  Copyright © 2019 Nail Safin. All rights reserved.
//

import UIKit
import INSPhotoGallery
import Kingfisher

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var postTime: UILabel!
    
    
    @IBOutlet weak var newsImage: UICollectionView!
    @IBOutlet weak var newsText: UILabel!
    var collection: [String] = []
    var fullscreenCollection: [INSPhoto] = []
    weak var vc: UIViewController? = nil
    
    @IBOutlet weak var constaintToolBar: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.newsImage.register(UINib.init(nibName: "img", bundle: nil), forCellWithReuseIdentifier: "img")
    }
    
    
    func setup(item: News, viewController: UIViewController?)
    {
        vc = viewController
        newsText.text = item.textNews
        avatar.kf.setImage(with: URL(string: item.avatar))
        postTime.text = item.publicDate.toDateString
        userName.text = item.userName
        collection = item.imageMin
        
        for i in item.imageMax.indices {
            let maxURL = URL(string: item.imageMax[i])
            let minURL = URL(string: item.imageMin[i])
            let ins = INSPhoto(imageURL: maxURL, thumbnailImageURL: minURL)
            fullscreenCollection.append(ins)
        }
        
        newsImage.dataSource = self
        newsImage.delegate = self
        newsImage.reloadData()
        
        if collection.isEmpty {
            constaintToolBar.constant = 20
        } else {
            constaintToolBar.constant = 120
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsText.text = nil
        avatar.image = nil
        postTime.text = nil
        userName.text = nil
        fullscreenCollection = []
        collection = []
        vc = nil
    }


    
}

extension NewsCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as? CollectionCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.image1.kf.setImage(with: URL(string: collection[indexPath.item]))
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath) as! CollectionCellCollectionViewCell

           let currentPhoto = fullscreenCollection[indexPath.row]
           let galleryPreview = INSPhotosViewController(photos: fullscreenCollection, initialPhoto: currentPhoto, referenceView: cell)

           galleryPreview.referenceViewForPhotoWhenDismissingHandler = { [weak self] photo in
            if let index = self?.fullscreenCollection.lastIndex(where: {$0 === photo}) {
                   let indexPath = IndexPath(row: index, section: 0)
                   return collectionView.cellForItem(at: indexPath) as? CollectionCellCollectionViewCell
               }
               return nil
           }
        vc?.present(galleryPreview, animated: true, completion: nil)
       }

}

