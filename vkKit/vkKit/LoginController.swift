//
//  LoginController.swift
//  
//
//  Created by Nail Safin on 15.01.2020.
//
import UIKit
import Alamofire
import WebKit

class LoginController: UIViewController
{
    var webView: WKWebView! 
    let  webViewConfig = WKWebViewConfiguration()
    let vkAppID = "7282510"
    let vkApi = VKApi()
    
    func getrequest() -> URLRequest
        
    {
        var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = "oauth.vk.com"
            urlComponent.path = "/authorize"
            urlComponent.queryItems = [URLQueryItem(name: "client_id", value: vkAppID),
                                          URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                          URLQueryItem(name: "display", value: "mobile"),
                                          URLQueryItem(name: "scope", value: "262150"),
                                          URLQueryItem(name: "response_type", value: "token"),
                                          URLQueryItem(name: "v", value: "5.103")]
        
        let request = URLRequest(url: urlComponent.url!)
        return request
    }
  
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        webView.load(getrequest())
        view = webView
        
    }
    
    
    
    
    
}

extension LoginController: WKNavigationDelegate
{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
    {
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
        
        //vkApi.getFriendlist(token: Session.shared.token, userID: Session.shared.userid)
        //vkApi.getGroupList(token: Session.shared.token, userID: Session.shared.userid)
        //vkApi.getPhoto(token: Session.shared.token, userID: Session.shared.userid)
        vkApi.searchGroup(token: Session.shared.token, userID: Session.shared.userid)
        decisionHandler(.cancel)
    }
}
