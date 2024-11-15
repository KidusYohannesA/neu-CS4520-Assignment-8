//
//  ChatsTableViewManager.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/11/24.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactsID, for: indexPath) as! ChatsTableViewCell
        cell.labelName.text = messageList[indexPath.row].sender
        cell.labelText.text = messageList[indexPath.row].text
        cell.labelDate.text = "\(messageList[indexPath.row].timestamp)"
        return cell
    }
}
