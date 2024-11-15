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
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
        cell.labelName.text = messageList[indexPath.row].sender
        cell.labelText.text = messageList[indexPath.row].text
        cell.labelDate.text = "\(messageList[indexPath.row].timestamp)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //MARK: TODO, displaying the chat screen
        let ChatViewController = ChatViewController()
        ChatViewController.recipient = messageList[indexPath.row].sender
        self.navigationController?.pushViewController(ChatViewController, animated: true)
    }
}
