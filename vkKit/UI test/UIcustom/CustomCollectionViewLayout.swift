
import UIKit
enum CollectionCustonSize
{
    case small
    case wide
}
class CustomCollectionViewLayout : UICollectionViewLayout
{
    var cacheAtributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var colums = 2
    var cellHeight = 150
    var containerHeight: CGFloat = 0
    override func prepare()
    {
        guard let collection = collectionView
            else { return}
        let itemsCount = collection.numberOfItems(inSection: 0)
        let commonWidth = collection.frame.width
        let smallWidth = collection.frame.width / CGFloat(colums)
        
        var x:CGFloat = 0
        var y:CGFloat = 0
        for element in 0..<itemsCount
        {
            let indexpath = IndexPath(item: element, section: 0)
            let attributeForIndex = UICollectionViewLayoutAttributes(forCellWith: indexpath)
            let isWide: CollectionCustonSize = (element + 1) % (colums + 1) == 0 ? .small : .wide
            switch isWide
            {
            case .wide:
                attributeForIndex.frame = CGRect (x: CGFloat(0),
                                                  y: y,
                                                  width: commonWidth,
                                                  height: CGFloat(cellHeight))
                 y += CGFloat(cellHeight)
            case .small:
                attributeForIndex.frame = CGRect (x: x,
                                                  y: y,
                                                  width: smallWidth,
                                                  height: CGFloat(cellHeight))
                if (element + 2) % (colums + 1) == 0 || element == itemsCount - 1
                {
                    y += CGFloat(cellHeight)
                    x = CGFloat(0)
                }
                else
                {
                    x += smallWidth
                }
                
                
            }
           
            cacheAtributes[indexpath] = attributeForIndex
        }
        
        containerHeight = y
        
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAtributes[indexPath]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAtributes.values.filter
            {
                rect.intersects($0.frame)
            }
        
    }
    override var collectionViewContentSize: CGSize
        {
        return CGSize(width: collectionView!.frame.width,
                      height: containerHeight)
        }
    
}
