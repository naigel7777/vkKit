//
//  NewsController.swift
//  UI test
//
//  Created by Nail Safin on 12.12.2019.
//  Copyright © 2019 Nail Safin. All rights reserved.
//

import UIKit
import INSPhotoGallery

class NewsViewController: UITableViewController
{

override func viewDidLoad()
{
    tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "simpleNews")
    tableView.estimatedRowHeight = 200.0
    tableView.rowHeight = UITableView.automaticDimension
    
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return NewsBase.getNews().count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleNews", for: indexPath) as? NewsCell
        else { return UITableViewCell() }
    cell.setup(item: NewsBase.getNews()[indexPath.row])
   
    cell.newsImage.dataSource = self
    cell.newsImage.delegate = self
    cell.newsImage.tag = indexPath.row
    cell.newsImage.reloadData()
    

    return cell
}
}
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsBase.getNews()[collectionView.tag].imagePath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as? CollectionCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.image1.image = UIImage(named: NewsBase.getNews()[collectionView.tag].imagePath[indexPath.item])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath) as! CollectionCellCollectionViewCell
        let photos =  NewsBase.getNews()[collectionView.tag].imagePath.map {INSPhoto(image: UIImage(named: $0), thumbnailImage: UIImage(named: $0)) }
           let currentPhoto = photos[indexPath.row]
           let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)

           galleryPreview.referenceViewForPhotoWhenDismissingHandler = { photo in
               if let index = try? photos.lastIndex(where: {$0 === photo}) {
                   let indexPath = IndexPath(row: index, section: 0)
                   return collectionView.cellForItem(at: indexPath) as? CollectionCellCollectionViewCell
               }
               return nil
           }
           present(galleryPreview, animated: true, completion: nil)
       }

}
