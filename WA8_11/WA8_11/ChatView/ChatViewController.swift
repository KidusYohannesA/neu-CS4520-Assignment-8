import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    var chatView = ChatView()
    var recipient: String!
    var chatId: String!
    var messages: [Chat] = []

    let db = Firestore.firestore()
    var currentEmail: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)
        chatView.frame = view.frame

        chatView.tableView.dataSource = self
        chatView.tableView.delegate = self
        chatView.tableView.register(ChatViewTableViewCell.self, forCellReuseIdentifier: "ChatCell")
        chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
 

        chatView.recipientLabel.text = "Chat with \(recipient ?? "")"

        if let email = Auth.auth().currentUser?.email {
            currentEmail = email
        } else {
            print("No user is logged in")
        }

        chatId = generateChatId(sender: currentEmail!, recipient: recipient)

        // Fetch existing messages
        fetchMessages()
    }

    func generateChatId(sender: String, recipient: String) -> String {
        return sender < recipient ? "\(sender)_\(recipient)" : "\(recipient)_\(sender)"
    }

    func fetchMessages() {
        db.collection("chats").document(chatId).collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    print("Error fetching messages: \(error)")
                    return
                }

                self?.messages.removeAll()

                querySnapshot?.documents.forEach { document in
                    if let chat = self?.fromFirestoreData(document.data()) {
                        self?.messages.append(chat)
                    }
                }

                self?.chatView.tableView.reloadData()
                self?.scrollToBottom()
            }
    }
    
    func scrollToBottom() {
        guard !messages.isEmpty else { return }
        let lastRow = messages.count - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        chatView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    @objc func sendMessage() {
        guard let text = chatView.messageTextField.text, !text.isEmpty else { return }

        let newChat = Chat(sender: currentEmail!, recipient: recipient!, text: text, timestamp: Date())

        db.collection("chats").document(chatId).collection("messages")
            .addDocument(data: toFirestoreData(newChat)) { error in
                if let error = error {
                    print("Error sending message: \(error)")
                } else {
                    // Clear the message input field
                    self.chatView.messageTextField.text = ""
                }
            }
    }

    func toFirestoreData(_ chat: Chat) -> [String: Any] {
        return [
            "sender": chat.sender,
            "recipient": chat.recipient,
            "text": chat.text,
            "timestamp": Timestamp(date: chat.timestamp)
        ]
    }

    func fromFirestoreData(_ data: [String: Any]) -> Chat? {
        guard let sender = data["sender"] as? String,
              let recipient = data["recipient"] as? String,
              let text = data["text"] as? String,
              let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() else {
            return nil
        }
        return Chat(sender: sender, recipient: recipient, text: text, timestamp: timestamp)
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatViewTableViewCell
        let chat = messages[indexPath.row]
        cell.configure(with: chat)
        return cell
    }
}

