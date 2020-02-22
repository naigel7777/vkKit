
import UIKit
import DotsLoading
//import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollview?.addGestureRecognizer(hideKeyboardGesture)
        animatedTitles()
        animatedSnow()
        
    }
    
    
    @objc func hideKeyboard()
    {
        self.scrollview?.endEditing(true)
    }

    @IBOutlet weak var inLogin: UITextField!
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var inPass: UITextField!
    
    @IBAction func RegistrationButton(_ sender: Any) {
  
    }
    @IBOutlet weak var TItleLogin: UILabel!
//    @IBAction func enter(_ sender: Any)
//    {
//        guard let email = inLogin.text,
//           let pass = inPass.text else { return }
//        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
//            if let id = result?.user.uid {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let VC = storyboard.instantiateViewController(identifier: "MainTabBar")
//                VC.modalPresentationStyle = .custom
//                VC.modalPresentationCapturesStatusBarAppearance = true
//                VC.transitioningDelegate = self
//                self.present(VC, animated: true)
//                print("User enter login - \(String(describing: self.inLogin.text!)) password - \(String(describing: self.inPass.text!)) ")
//            } else {
//                self.showLoginError()
//            }
//        }
//        
//        
//    }
    
    @IBOutlet weak var scrollview: UIScrollView!
    let animation = AnimatorTransition()
    @objc func keyboardWasshow (notification: Notification)
    {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsetts = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollview?.contentInset = contentInsetts
        scrollview?.scrollIndicatorInsets = contentInsetts
    }
    @objc func keyboardWillBeHidden (notification: Notification)
    {
        let contentInsrts = UIEdgeInsets.zero
        scrollview.contentInset = contentInsrts
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasshow), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   /*override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       let checkResult = checkUserData()
       
       if !checkResult {
           showLoginError()
       }
       return checkResult
   }
   
   func checkUserData() -> Bool {
       guard let login = inLogin.text,
        let password = inPass.text else { return false }
 //   Auth.auth().
       if login == "admin" && password == "123456" {
           return true
       } else {
           return false
       }
   }*/
   
   func showLoginError() {
       let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
       let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
       alter.addAction(action)
       present(alter, animated: true, completion: nil)
   }

    func animatedTitles()
    {
        /*
        let sublightLayer = CAShapeLayer()
        sublightLayer.path =
            sublightLayer.strokeColor = UIColor.clear.cgColor
        */
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.Logo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        self.Logo.alpha = 0.2
                        
        }/*, completion: {_ in
            self.Logo.alpha = 1
            
        }*/)
   
        
    }
    
    func animatedSnow()
    {
       let emitterSnow = CAEmitterCell()
        emitterSnow.contents = UIImage(named: "snowflake3")?.cgImage
        emitterSnow.scale = 0.02
        emitterSnow.scaleRange = 0.05
        emitterSnow.birthRate = 1
        emitterSnow.emissionRange = .pi
        emitterSnow.lifetime = 15
        emitterSnow.velocity = -30
        emitterSnow.velocityRange = -20
        emitterSnow.yAcceleration = 10
        emitterSnow.xAcceleration = 0
        emitterSnow.spin = -0.5
        emitterSnow.spinRange = 1
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
        emitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        emitterLayer.emitterShape = .line
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.timeOffset = 15
        emitterLayer.emitterCells = [emitterSnow]
        view.layer.addSublayer(emitterLayer)
        
    }
}

class AnimatorTransition: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard let source = transitionContext.viewController(forKey: .from),
        let to = transitionContext.viewController(forKey: .to)
        else
        {
            return
            
        }

        transitionContext.containerView.addSubview(to.view)
       to.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: 90 * .pi / 180))
       to.view.frame = CGRect(x: transitionContext.containerView.frame.width,
                              y: transitionContext.containerView.frame.width,
                              width: source.view.frame.width,
                              height: source.view.frame.height)
       // to.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: 90 * .pi / 180))
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       animations: {
                        source.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: -90 * .pi / 180))
                    source.view.frame = CGRect(x: -source.view.frame.width,
                                               y: -source.view.frame.width,
                                               width: source.view.frame.width,
                                               height: source.view.frame.height)
                       // source.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: -90 * .pi / 180))
                        to.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: 0 * .pi / 180))
                    to.view.frame = CGRect(x: 0,
                                           y: 0,
                                           width: transitionContext.containerView.frame.width,
                                           height: transitionContext.containerView.frame.height)
                     //   to.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: 0 * .pi / 180))
        })
        {isCompleted in
            transitionContext.completeTransition(isCompleted)
        }
    }
}


extension ViewController: UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animation
    }
    
    
    
}
/*class CustomAnimation: NSObject, UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        <#code#>
    }
    
    
    
}*/

