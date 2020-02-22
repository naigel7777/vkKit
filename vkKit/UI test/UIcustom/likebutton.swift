import UIKit
class LikeButton: UIButton
{
    var liked: Bool = false
    {
    didSet
        {
        if liked
            {
            setLiked()
            }
         else
            {
            disableLike()
            }
        }
    }
    var likeCount = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupDefault()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        setupDefault()
    }
    
    func like()
    {
        liked = !liked
    }
    
    func setupDefault()
    {
       setImage(UIImage(named: "dislike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .gray
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
       
    }
    
    func setLiked()
    {
        likeCount += 1
        setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .red
        animatedLikeButton()
    }
    
    func disableLike()
    {
        likeCount -= 1
        setImage(UIImage(named: "dislike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .gray
        animatedLikeButton()
    }
    
    func animatedLikeButton()
    {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.1
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 1
        animation.duration = 1
        //animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.both
        layer.add(animation, forKey: nil)
    }
}
