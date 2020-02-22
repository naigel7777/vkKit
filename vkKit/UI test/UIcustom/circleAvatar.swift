

import Foundation
import UIKit
class circleAvatar: UIView
{
    var image: UIImageView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addImage()
        animatedAvatar()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        addImage()
        animatedAvatar()
    }
    
    func addImage()
    {
        image = UIImageView(frame: frame)
        addSubview(image)
    }
    
    override func layoutSubviews()
    {
        image.frame = bounds
        layer.cornerRadius = bounds.size.height / 2
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize.init(width: 0, height: 1)
        layer.cornerRadius = bounds.size.height / 2
        image.layer.masksToBounds = true
    }
     func animatedAvatar()
        {
            let animation = CASpringAnimation(keyPath: "transform.scale")
            animation.fromValue = 1.1
            animation.toValue = 1
            animation.stiffness = 500
            animation.mass = 1
            animation.duration = 1
            animation.beginTime = CACurrentMediaTime() + 1
            animation.fillMode = CAMediaTimingFillMode.both
            layer.add(animation, forKey: nil)
        }
    }
    

