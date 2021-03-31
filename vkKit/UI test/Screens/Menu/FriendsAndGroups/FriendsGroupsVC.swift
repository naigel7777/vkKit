//
//  FriendsGroupsVC.swift
//  UI test
//
//  Created by Nail Safin on 13.05.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit

final class FriendsGroupsVC: UIViewController {

    private let mainView = FriendsGroupsView()
    private let vm: FriendsGroupsAbstractVM
   
    
    
    init(type: ItemsFG) {
        self.vm = FriendsGroupsVM(type: type)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
        mainView.rowsFG.delegate = self
        mainView.rowsFG.dataSource = self
        
        vm.get()
        vm.reloadCallBack = { [weak self] in self?.mainView.rowsFG.reloadData() }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    



}
extension FriendsGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(cell: FriendGroupCell.self, at: indexPath)
        cell.bind(model: vm.items[indexPath.row])
        return cell
    }
    
    
}
