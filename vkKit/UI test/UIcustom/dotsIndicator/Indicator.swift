
import Foundation
import UIKit
class Indicator : UIView
{
    
    @IBOutlet weak var indicatorSecond: circleAvatar!
    @IBOutlet weak var indicatorFirst: circleAvatar!
    @IBOutlet weak var indicatorThird: circleAvatar!
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        XibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        XibSetup()
    }
    func animate()
    {
        UIView.animate(withDuration:  0.6,
                       delay: 0,
                       options: [.repeat, .autoreverse, .curveLinear],
                       animations:
            {
                self.indicatorFirst.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.indicatorFirst.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        UIView.animate(withDuration:  0.6,
                       delay: 0.3,
                             options: [.repeat, .autoreverse, .curveLinear],
                             animations:
                  {
                      self.indicatorSecond.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
              }) { _ in
                  self.indicatorSecond.transform = CGAffineTransform(scaleX: 1, y: 1)
              }
              
        UIView.animate(withDuration:  0.6,
                       delay: 0.6,
                             options: [.repeat, .autoreverse, .curveLinear],
                             animations:
                  {
                      self.indicatorThird.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
              }) { _ in
                  self.indicatorThird.transform = CGAffineTransform(scaleX: 1, y: 1)
              }
           
    }
    
    func XibSetup()
    {
       contentView = loadFromXib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        animate()
    }
    
    func loadFromXib() -> UIView
    {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    
    
    
}
