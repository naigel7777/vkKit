import Foundation
import UIKit
class Avatar: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 20
    {
        didSet
        {
            setNeedsDisplay()
        }
    }
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = cornerRadius
      
        
     
        let img = UIImageView()
        img.image = UIImage(named: "123.png")
       self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowOpacity = 0.5
       self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize.zero
       self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = cornerRadius
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
}

