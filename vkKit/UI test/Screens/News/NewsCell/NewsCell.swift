//
//  NewsCell.swift
//  UI test
//
//  Created by Nail Safin on 12.12.2019.
//  Copyright © 2019 Nail Safin. All rights reserved.
//

import UIKit
import INSPhotoGallery

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var postTime: UILabel!
    
    
    @IBOutlet weak var newsImage: UICollectionView!
    @IBOutlet weak var newsText: UILabel!
    var collection: [UIImage?] = []
    weak var vc: UIViewController? = nil
    
    override func awakeFromNib() {
        self.newsImage.register(UINib.init(nibName: "img", bundle: nil), forCellWithReuseIdentifier: "img")
    }
    
    
    func setup(item: News, viewController: UIViewController?)
    {
        vc = viewController
        newsText.text = item.textNews
        avatar.image = getImg(item.avatar)
        postTime.text = item.publicDate
        userName.text = item.userName
        item.imagePath.forEach { (imm) in
            collection.append(getImg(imm))
        }
        newsImage.dataSource = self
        newsImage.delegate = self
        newsImage.reloadData()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsText.text = nil
        avatar.image = nil
        postTime.text = nil
        userName.text = nil
        collection = []
        vc = nil
    }
    
    private func getImg(_ stringUrl: String) -> UIImage? {
        var image: UIImage? = UIImage()
        if let url = URL(string: stringUrl), let imgData = try? Data(contentsOf: url) {
                   image = UIImage(data: imgData)
               }
        return image
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
        cell.image1.image = collection[indexPath.item]
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath) as! CollectionCellCollectionViewCell
        let photos =  collection.map {INSPhoto(image: $0, thumbnailImage: $0) }
           let currentPhoto = photos[indexPath.row]
           let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)

           galleryPreview.referenceViewForPhotoWhenDismissingHandler = { photo in
               if let index = photos.lastIndex(where: {$0 === photo}) {
                   let indexPath = IndexPath(row: index, section: 0)
                   return collectionView.cellForItem(at: indexPath) as? CollectionCellCollectionViewCell
               }
               return nil
           }
        vc?.present(galleryPreview, animated: true, completion: nil)
       }

}

