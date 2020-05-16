
import UIKit
import INSPhotoGallery

private let reuseIdentifier = "photo"

class PhotoController: UICollectionViewController, UINavigationControllerDelegate
{
    var photoCollection = ["ph1","ph2","ph3","ph4","ph5"]
    var photosUser = [ItemPhoto](){
        didSet{
            if !photosUser.isEmpty {
                photosUser.forEach { (item) in
                    let url = URL(string: item.sizes[0].url)
                    photos.append(INSPhoto(imageURL: url, thumbnailImageURL: url))
                }
            }
        }
    }
    var user: String?
    var ownerID = 1
    var vkApi : VKApi?
    var transInteraction: UIPercentDrivenInteractiveTransition?
    var photos: [INSPhotoViewable] = []
    
//MARK: LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let edgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgeRecognize(_:)))
//        edgeRecognizer.edges = .left
//        view.addGestureRecognizer(edgeRecognizer)
        navigationController?.delegate = self
        vkApi = VKApi(self)
        vkApi?.getPhoto(token: Session.shared.token, ownerID: String(describing: ownerID)) { (photos) in
            self.photosUser = photos
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
//MARK: ANIMATION edge recognise 50%
    @objc func edgeRecognize(_ gesture: UIScreenEdgePanGestureRecognizer)
    {
        let translation = gesture.translation(in: gesture.view)
        let percentComplete = translation.x / gesture.view!.bounds.size.width
        switch gesture.state {
        case .began: transInteraction = UIPercentDrivenInteractiveTransition()
        case .changed: transInteraction?.update(percentComplete)
        case .ended: let velocity = gesture.velocity(in: gesture.view)
        if velocity.x > 0 || percentComplete > 0.5
        {
            transInteraction?.finish()
        } else {
            transInteraction?.cancel()
        }
        transInteraction = nil
        default: break
        }
    }
    func navigationController(_ navigationController: UINavigationController,
                              
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transInteraction
    }
  //MARK: Configurate collection view
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return photosUser.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell
            else
        {
            return UICollectionViewCell()
        }
        let photo = photosUser[indexPath.row]
        if let url = URL(string: photo.sizes[0].url) {
            cell.Photo.kf.setImage(with: url)
        }
       
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        let currentPhoto = photos[indexPath.row]
        let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)

        galleryPreview.referenceViewForPhotoWhenDismissingHandler = { [weak self] photo in
            if let index = try? self?.photos.lastIndex(where: {$0 === photo}) {
                let indexPath = IndexPath(row: index, section: 0)
                return collectionView.cellForItem(at: indexPath) as? PhotoCell
            }
            return nil
        }
        present(galleryPreview, animated: true, completion: nil)
    }

    

}
//MARK: CELLS

class PhotoCell: UICollectionViewCell
{
    
    @IBOutlet weak var Photo: UIImageView!
      
    @IBAction func pushLike(_ sender: Any)
    {
        (sender as! LikeButton).like()
    }
    
}

