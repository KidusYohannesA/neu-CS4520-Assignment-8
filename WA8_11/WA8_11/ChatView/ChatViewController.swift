//
//  ChatViewController.swift
//  WA8_11
//
//  Created by Akshay Tolani on 11/14/24.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chatView = ChatView()
    var recipient: String?
    var currentEmail: String?
    var chats: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)
        chatView.frame = view.frame
        
        if let email = Auth.auth().currentUser?.email {
            currentEmail = email
        } else {
            print("No user is logged in")
        }
        
        chatView.recipientLabel.text = recipient
        chatView.tableView.delegate = self
        chatView.tableView.dataSource = self
        chatView.tableView.register(ChatViewTableViewCell.self, forCellReuseIdentifier: "chatCell")
        
        chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        fetchChats()
    }
    
    func fetchChats() {
        // Fetch from Firebase (Firestore example)
        let db = Firestore.firestore()
        db.collection("chats").order(by: "timestamp", descending: false).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching chats: \(error)")
            } else {
                self.chats = snapshot?.documents.compactMap({ doc -> Chat? in
                    let data = doc.data()
                    let sender = data["sender"] as? String ?? ""
                    let recipient = data["recipient"] as? String ?? ""
                    let text = data["text"] as? String ?? ""
                    let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                    return Chat(sender: sender, recipient: recipient, text: text, timestamp: timestamp)
                }) ?? []
                self.chatView.tableView.reloadData()
            }
        }
    }
    
    @objc func sendMessage() {
        guard let text = chatView.messageTextField.text, !text.isEmpty else { return }
        
        let newChat = Chat(sender: currentEmail ?? "Unknown", recipient: recipient ?? "Unknown", text: text, timestamp: Date())
        chats.append(newChat)
        chatView.tableView.reloadData()
        chatView.messageTextField.text = ""
        
        // Save to Firebase
        let db = Firestore.firestore()
        db.collection("chats").addDocument(data: [
            "sender": newChat.sender,
            "recipient": newChat.recipient,
            "text": newChat.text,
            "timestamp": newChat.timestamp
        ]) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatViewTableViewCell
        let chat = chats[indexPath.row]
        cell.configure(with: chat)
        return cell
    }

}
