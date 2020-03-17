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
    var needMoreNews = false
    var nextFrom = ""
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        addRefreshConrol()
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
        
        vkApi.getNextNews(token: Session.shared.token, nextFrom: nextFrom) { [weak self] result, next in
            self?.news = []
            self?.news.append(contentsOf: result)
            
            self?.nextFrom = next
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            self?.datdbase.addLastNews(news: result)
            self?.needMoreNews = true
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
    
    @objc func refreshTable() {
        
        vkApi.getNextNews(token: Session.shared.token, nextFrom: nextFrom) { [weak self] result, next in
            self?.nextFrom = "0"
            self?.news = []
            self?.news.append(contentsOf: result)
            self?.nextFrom = next
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.customRefreshControl.endRefreshing()
            }
            self?.datdbase.addLastNews(news: result)
            self?.needMoreNews = true
        }
        
    }
    
    //MARK: - Handlers Configuration TableView
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
    return news.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleNews", for: indexPath) as? NewsCell
        else { return UITableViewCell() }
    cell.setup(item: news[indexPath.row], viewController: self)
    return cell
}

}

//MARK: - Prefetching more News
extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard needMoreNews,
            let maxRow = indexPaths.map({$0.row}).max(),
            news.count <= maxRow + 1
            else { return }
        needMoreNews = false
        vkApi.getNextNews(token: Session.shared.token, nextFrom: nextFrom) { [weak self] result, next in
            self?.news.append(contentsOf: result)
            self?.nextFrom = next
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            self?.needMoreNews = true
        }
        
    }
}



