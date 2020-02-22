//
//  messageController.swift
//  UI test
//
//  Created by Nail Safin on 12.12.2019.
//  Copyright © 2019 Nail Safin. All rights reserved.
//

import UIKit
class MessageViewController: UITableViewController
{
    var messageArray = [1,2,3,4,5,6,7]
    override func viewDidLoad()
    {
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "simpleMessage")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleMessage", for: indexPath) as? MessageCell
            else { return UITableViewCell() }
        cell.message.text = "LongText LongText LongText LongText LongText LongText LongTextLongTextLongTextLongTextLongTextLongTextLongText"
        return cell
    }
}
