import UIKit
import Kingfisher
import RealmSwift


class TableViewGroup: UITableViewController {
    
//    struct Section<T> {
//        var title: String
//        var item: [T]
//    }

   
    
    @IBOutlet weak var search2: UISearchBar!
    private var vkApi = VKApi()
    var database = RepositoryRealmGroup()
    var groups: Results<RealmGroups>?
    var token: NotificationToken?
    var errorParser = VKapiErrorParser()
    weak var vc: UIViewController?
    var searchingGroup = [ItemGroup]()
//    var groupSection = [Section<ItemGroup>]()
    
    @IBAction func addsearch(_ sender: Any) {
        if search2.isHidden {
            search2.isHidden = false
            search2.frame.size.height = 44
            
        } else {
            search2.isHidden = true
            search2.frame.size.height = 0
            vkApi.getGroupList(token: Session.shared.token, userID: Session.shared.userid) { result in
                switch result {
                case .success(let groups):
                    self.database.addAllGroups(groups: groups)
                    DispatchQueue.main.async {
          //              self.makeSortedSection()
                        self.tableView.reloadData()
                    }
                case .failure(let err):
                    self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQEST")
                    print ("GOT ERROR \(err)")
                }
                
            }
        }
        tableView.reloadData()
        
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        search2.delegate = self
        
        search2.isHidden = true
        search2.frame.size.height = 0
        addRefreshConrol()
        showGroups()
        vkRequest()
        
        
        
    }
    
    func showGroups() {
        do {
            groups = try database.getAllGroups()
            token = groups?.observe { [weak self] results in
                switch results {
                case .error(let error): print(error)
                case .initial: self?.tableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.endUpdates()
                }
            }
        } catch {
            print (error)
        }
    }
//MARK: ADD REQUEST
    func vkRequest(){
        vkApi.getGroupList(token: Session.shared.token, userID: Session.shared.userid) { result in
                 switch result {
                 case .success(let groups):
                    self.database.addAllGroups(groups: groups)
              
                 case .failure(let err):
                     self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQEST")
                     print ("GOT ERROR \(err)")
                 }
                 
                 
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
        vkApi.getGroupList(token: Session.shared.token, userID: Session.shared.userid) { result in
            
            
            switch result {
            case .success(let groups):
                self.database.addAllGroups(groups: groups)
            DispatchQueue.main.async {
 //               self.makeSortedSection()
                self.tableView.reloadData()
            }
                case.failure(let err):
                self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQEST")
                print ("GOT ERROR \(err)")
            
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.customRefreshControl.endRefreshing()
        }
    }
    }
  //MARK: Make sorted sections

//    func makeSortedSection() {
//        let groupDictionary = Dictionary.init(grouping: groups)
//        {
//            $0.name.prefix(1)
//        }
//        groupSection = groupDictionary.map { Section(title: String($0.key), item: $0.value)}
//        groupSection.sort {$0.title < $1.title}
//    }
    // MARK: Configurate Table View
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return groups?.count ?? 0
//    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCells", for: indexPath) as? GroupCells,
            let group = groups?[indexPath.row]
            else {
                return UITableViewCell()
            }
      /*  let item = groupSection[indexPath.section].item[indexPath.row]
        cell.NameGroup.text =  item.name
        let url = URL(string: item.photo50)
        cell.groupImage.image.kf.setImage(with: url)*/
       
        cell.NameGroup.text = group.groupName
        let url = URL(string: group.avatarPath)
        cell.groupImage.image.kf.setImage(with: url)
        
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return groupSection[section].title
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let group = groups?[indexPath.row] {
              database.deleteGroup(group: group)
            }
            
   //         groupSection[indexPath.section].item.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return groupSection.map {$0.title}
//    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//       let view = UIView()
//        view.backgroundColor = UIColor.white
//
//        let label = UILabel()
//        label.text = groupSection[section].title
//        label.frame = CGRect(x: 10, y: 15, width: 8, height: 15)
//        label.textColor = UIColor.darkGray
//        label.adjustsFontSizeToFitWidth = true
//        view.addSubview(label)
//
//       return view
//    }
//}

//MARK: Search Group Delegate
}
extension TableViewGroup: UISearchBarDelegate {
/*    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.count >= 3 {
            vkApi.searchGroup(token: Session.shared.token, searchText: searchText) { result in
                   switch result {
                            case .success(let groups):
                                self.groups = groups
                            DispatchQueue.main.async {
                               self.makeSortedSection()
                                self.tableView.reloadData()
                            }
                                case.failure(let err):
                                self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQEST")
                                print ("GOT ERROR \(err)")
                            
                            }
                       
                        
            }
        }
        else if searchText.isEmpty {
            vkApi.getGroupList(token: Session.shared.token, userID: Session.shared.userid) { result in
                          switch result {
                            case .success(let groups):
                                self.groups = groups
                            DispatchQueue.main.async {
                               self.makeSortedSection()
                                self.tableView.reloadData()
                            }
                                case.failure(let err):
                                self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQEST")
                                print ("GOT ERROR \(err)")
                            
                            }
                           
            }
        }

    }*/
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        do {
            self.groups = searchText.isEmpty ? try database.getAllGroups() : try database.searchGroups(name: searchText.lowercased())
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
    }
    
}


class GroupCells: UITableViewCell {
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var groupImage: circleAvatar!
    @IBOutlet weak var NameGroup: UILabel!
}