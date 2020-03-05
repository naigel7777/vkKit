import UIKit
import Kingfisher
import WebKit

struct Section<T> {
     var title: String
     var item: [T]
 }
protocol FriendsControllerView: class {
    func updateTable()
    func addsubview(crc: UIRefreshControl)

    
}


class FriendsController: UITableViewController {
    
    @IBOutlet weak var searchBarFriends: UISearchBar!
    
    @IBAction func exitbutton(_ sender: Any) {// DOES NOT WORK !!!
       
        webView2?.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
            cookies.forEach {  self?.webView2?.configuration.websiteDataStore.httpCookieStore.delete($0) }
        }
        self.vc?.performSegue(withIdentifier: "unwindToLogin", sender: self)
        }
        

    var webView2: WKWebView?
    var presenter: FriendsPresenter?
    var configurator: FriendsConfigurator?
    var vc: UIViewController?
 
    var customRefreshControl = UIRefreshControl()
   
  
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator = FriendsConfiguratorImplementation()
        configurator?.configure(view: self)
        presenter?.viewDidLoad2()
        searchBarFriends.delegate = self
        
        if let vc = presentingViewController?.presentingViewController as? VKLoginController {
            webView2 = vc.webView
        }
    }
    

//MARK: Configuration Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
         
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTemplate", for: indexPath) as? FriendCell,
        
              let model = presenter?.getModelAtIndex(indexPath: indexPath)
            else { return UITableViewCell() }
        cell.bind(model: model)
        

        return cell
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        
        label.text = presenter?.getTitleForSection(section: section)?.capitalized
    
        label.frame = CGRect(x: 10, y: 15, width: 14, height: 15)
        label.textColor = UIColor.darkGray
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
       return view
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter?.getSectionIndexTitles()
    }
    
    
//MARK: Crate collection view with foto friend
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user1 = presenter?.getModelAtIndex(indexPath: indexPath)?.userName ?? "UserName"
        let surname1 = presenter?.getModelAtIndex(indexPath: indexPath)?.surName ?? "SurName"
        let fullName = user1 + " " + surname1
        
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard1.instantiateViewController(identifier: "photocontroller") as! PhotoController
        viewController.user = fullName
        viewController.title = fullName
        viewController.ownerID = presenter?.getModelAtIndex(indexPath: indexPath)?.id ?? 0
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    

    

}

extension FriendsController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        presenter?.searchFriends(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
   {
    view.endEditing(true)
    }
    
    @IBAction func unwindBackToFriends(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
    
    }
    
    
}
extension FriendsController: FriendsControllerView {

    
    func updateTable() {
        tableView.reloadData()
    }
    func addsubview(crc: UIRefreshControl) {
        tableView.addSubview(crc)
    }
   

}

class FriendCell: UITableViewCell
{
    
    @IBOutlet weak var isOnline: UIImageView!
    
    @IBOutlet weak var LabelFriendCell: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var circleavatar: circleAvatar!
    
    func bind(model: RealmFriends) {
        
     
        let username = model.userName
        let surname = model.surName
        self.LabelFriendCell.text = username + " " + surname
        self.isOnline.image = UIImage(named: String(model.isOnline))
    
        let url = URL(string: model.avatarPath)
        self.avatar.kf.setImage(with: url)
        self.avatar.layer.cornerRadius = 25
        
    }
}
