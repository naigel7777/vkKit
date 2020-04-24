import UIKit
import Kingfisher
import RealmSwift


class TableViewGroup: UITableViewController {
    
    struct Section<T> {
        var title: String
        var item: [T]
    }

   
    
    @IBOutlet weak var search2: UISearchBar!
    private var vkApi = VKApi()
    var database = RepositoryRealmGroup()
    var groups: Results<RealmGroups>!
    var token: NotificationToken?
    var errorParser = VKapiErrorParser()
    weak var vc: UIViewController?
    var searchingGroup = [ItemGroup]()
    var groupSection = [Section<RealmGroups>]()
    
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
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGroupsFromRealm()
       promiseVkRequest()
    }
    
    private func getGroupsFromRealm() {
        do {
            self.groups = try database.getAllGroups()
        self.makeSortedSection()
            self.tableView.reloadData()
        }
        catch { print(error)}
        }
    
    func showGroups() {
        do {
            groups = try database.getAllGroups()
            token = groups?.observe { [weak self] results in
                switch results {
                case .error(let error): print(error)
                case .initial, .update:
                    self?.groups = try? self?.database.getAllGroups()
                    self?.makeSortedSection()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
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
    
    func promiseVkRequest() {
        let promise = vkApi.getGroupListFuture(token: Session.shared.token, userID: Session.shared.userid)
        
        promise.done { (groups) in
            self.database.addAllGroups(groups: groups)
        }.catch { (error) in
            print(error)
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
    
                case.failure(let err):
                self.errorParser.showErrorAlert(self.vc, errorMessage: "BAD REQEST")
                print ("GOT ERROR \(err)")
            
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.customRefreshControl.endRefreshing()
        }
    }
    }
 // MARK: Make sorted sections

    func makeSortedSection() {
        let groupDictionary = Dictionary.init(grouping: groups) { $0.name.prefix(1) }
        groupSection = groupDictionary.map { Section(title: String($0.key), item: $0.value)}
        groupSection.sort {$0.title < $1.title}
    }
 //    MARK: Configurate Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupSection[section].item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCells", for: indexPath) as? GroupCells
            else { return UITableViewCell() }
        cell.bind(model: groupSection[indexPath.section].item[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupSection[section].title
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group =  groupSection[indexPath.section].item[indexPath.row]
                database.deleteGroup(group: group)

            groupSection[indexPath.section].item.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupSection.map {$0.title}
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label: UILabel = {
            $0.text = groupSection[section].title
            $0.frame = CGRect(x: 5, y: 5, width: 25, height: 25)
            $0.textColor = .seaGreen
            $0.font = .brandFont
            $0.textAlignment = .center
            return $0
        }(UILabel())
        
        view.addSubview(label)
        
        return view
    }
}

//MARK: Search Group Delegate

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
    
    func bind(model: RealmGroups) {
        self.NameGroup.text = model.name
        let url = URL(string: model.photo50)
        self.groupImage.image.kf.setImage(with: url)
    }
    
}
