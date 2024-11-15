//
//  ChatView.swift
//  WA8_11
//
//  Created by Akshay Tolani on 11/14/24.
//

import UIKit

class ChatView: UIView {
    
    var recipientLabel: UILabel!
    var tableView: UITableView!
    var messageInputContainer: UIView!
    var messageTextField: UITextField!
    var sendButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupReceipientLabel()
        setupTableView()
        setupMessageInputContainer()
        setupMessageTextField()
        setupSendButton()
        
        initConstraints()
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupReceipientLabel() {
        recipientLabel = UILabel()
        recipientLabel.textAlignment = .center
        recipientLabel.font = UIFont.boldSystemFont(ofSize: 20)
        recipientLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(recipientLabel)
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
    }
    
    func setupMessageInputContainer() {
        messageInputContainer = UIView()
        messageInputContainer.backgroundColor = .white
        messageInputContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageInputContainer)
    }
    
    func setupMessageTextField() {
        messageTextField = UITextField()
        messageTextField.placeholder = "Enter message ..."
        messageTextField.borderStyle = .roundedRect
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageTextField)
    }
    
    func setupSendButton() {
        sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sendButton)
    }
    
    func initConstraints() {
        
        NSLayoutConstraint.activate([
            
            recipientLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            recipientLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recipientLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: recipientLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            
            messageInputContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageInputContainer.heightAnchor.constraint(equalToConstant: 60),
            
            messageTextField.leadingAnchor.constraint(equalTo: messageInputContainer.leadingAnchor, constant: 10),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputContainer.centerYAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),
            messageTextField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: messageInputContainer.trailingAnchor, constant: -10),
            sendButton.centerYAnchor.constraint(equalTo: messageInputContainer.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
        ])
        
    }
    
    
}
