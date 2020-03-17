//
//  VKLoginController.swift
//  UI test
//
//  Created by Nail Safin on 20.01.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import DotsLoading

class VKLoginController: UIViewController {
    
        //MARK: - Propites
    var webView: WKWebView!
    let  webViewConfig = WKWebViewConfiguration()
    let vkAppID = "7282510"
    let vkApi = VKApi()
    var loadingView: DotsLoadingView = DotsLoadingView(colors: nil)
    var dotsIndicator: Indicator = Indicator(frame: CGRect(x: 50, y: 50, width: 400, height: 200))
    let animationVK = AnimatorTransition()
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        
    }
    
   
    
     //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        view = webView
        webView.load(getrequest())

    }
    
      //MARK: - Handlers
    func getrequest() -> URLRequest {
           var urlComponent = URLComponents()
           urlComponent.scheme = "https"
           urlComponent.host = "oauth.vk.com"
           urlComponent.path = "/authorize"
           urlComponent.queryItems = [URLQueryItem(name: "client_id", value: vkAppID),
                                      URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                      URLQueryItem(name: "display", value: "mobile"),
                                      URLQueryItem(name: "scope", value: "friends, photos, groups, wall"),
                                      URLQueryItem(name: "response_type", value: "token"),
                                      URLQueryItem(name: "v", value: "5.103")]
           
           let request = URLRequest(url: urlComponent.url!)
           return request
       }
}

      //MARK: - Animator transition
extension VKLoginController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationVK
    }
      
}

      //MARK: - Navigation delegate
extension VKLoginController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else
        {
            
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=")}.reduce([String: String]()) {
                value, params in
                var dictionary = value
                let key = params[0]
                let value = params[1]
                dictionary[key] = value
                return dictionary
        }
        print(params)
        Session.shared.token = params["access_token"]!
        Session.shared.userid = params["user_id"]!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let VC = storyboard.instantiateViewController(identifier: "MainTabBar")
        VC.modalPresentationStyle = .custom
        VC.modalPresentationCapturesStatusBarAppearance = true
        VC.transitioningDelegate = self
        present(VC, animated: true)
        decisionHandler(.cancel)
    }
}
