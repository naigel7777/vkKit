//
//  NewsController.swift
//  UI test
//
//  Created by Nail Safin on 12.12.2019.
//  Copyright © 2019 Nail Safin. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    //MARK: - Propites
    private var vSpinner : UIView?
    let vkApi = VKApi()
    var news = [News]()
    let datdbase = RepositoryRealmNews()
    var isFetchingMoreNews = false
    var nextFrom = ""
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        addRefreshConrol()
        self.showSpinner(onView: self.view)
        regiserRows()
        showNewsFromRealm()
        getRequest()
        
    }
    
    private func regiserRows() {
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "simpleNews")
     
    }

    //MARK: - Handlers
    private func showNewsFromRealm() {
        if let realmNews = self.datdbase.getAllNews() {
            self.news = realmNews
        }
    }
    private func getRequest() {
//        vkApi.getNextNews(token: Session.shared.token, nextFrom: nextFrom) { result, next in
//            self.news.append(contentsOf: result)
//            self.nextFrom = next
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
//            self.datdbase.addLastNews(news: result)
//        }
        vkApi.getNews(token: Session.shared.token) { (result) in
            self.news = result
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }

            self.datdbase.addLastNews(news: result)
        }
    }
    // MARK: Refresh controll
    var customRefreshControl = UIRefreshControl()
    func addRefreshConrol()
    {
        customRefreshControl.attributedTitle = NSAttributedString(string: "Обновление")
        customRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
    }
    
    @objc func refreshTable()
    {
        vkApi.getNews(token: Session.shared.token, async: { (result) in
            self.news = result
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            self.datdbase.addLastNews(news: result)
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.customRefreshControl.endRefreshing()
        }
    }
    
    //MARK: - Handlers Configuration TableView
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return news.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleNews", for: indexPath) as? NewsCell
        else { return UITableViewCell() }
    cell.setup(item: news[indexPath.row], viewController: self)
    return cell
}

}
//MARK: - Add loading spiner - Activity indicator
extension NewsViewController {

func showSpinner(onView : UIView) {
    let spinnerView = UIView.init(frame: onView.bounds)
    spinnerView.backgroundColor = .clear
    let ai = UIActivityIndicatorView()
    ai.style = .large
    ai.color = .black
    ai.startAnimating()
    ai.center = spinnerView.center

    DispatchQueue.main.async {
        onView.addSubview(spinnerView)
        spinnerView.bringSubviewToFront(onView)
        spinnerView.addSubview(ai)
        ai.bringSubviewToFront(spinnerView)
        
    }

    vSpinner = spinnerView
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        self?.vSpinner?.removeFromSuperview()
        self?.vSpinner = nil
    }
}
}
//MARK: - Prefetching more News
extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isFetchingMoreNews,
            let maxRow = indexPaths.map({$0.row}).max(),
            news.count <= maxRow + 3
            else { return }
        isFetchingMoreNews = true
        vkApi.getNextNews(token: Session.shared.token, nextFrom: nextFrom) { result, next in
            self.news.append(contentsOf: result)
            self.nextFrom = next
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
//            self.datdbase.addLastNews(news: result)
        }
        isFetchingMoreNews = false
    }
}



