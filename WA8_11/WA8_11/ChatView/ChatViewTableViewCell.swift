//
//  ChatViewTableViewCell.swift
//  WA8_11
//
//  Created by Akshay Tolani on 11/14/24.
//

import UIKit
import FirebaseAuth

class ChatViewTableViewCell: UITableViewCell {

    var currentEmail: String?
    var messageLabel: UILabel!
    var bubbleBackgroundView: UIView!
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let email = Auth.auth().currentUser?.email {
            currentEmail = email
        } else {
            print("No user is logged in")
        }
        
        setupBubbleBackgroundView()
        setupMessageLabel()
        initConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBubbleBackgroundView() {
        bubbleBackgroundView = UIView()
        bubbleBackgroundView.layer.cornerRadius = 16
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bubbleBackgroundView)
    }

    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(messageLabel)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -10),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10)
        ])
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        
        leadingConstraint.isActive = false
        trailingConstraint.isActive = false
    }
    
    func configure(with chat: Chat) {
        messageLabel.text = chat.text
        
        if chat.sender == currentEmail {
            bubbleBackgroundView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            trailingConstraint.isActive = true
            leadingConstraint.isActive = false
        } else {
            bubbleBackgroundView.backgroundColor = .systemGray
            messageLabel.textColor = .black
            trailingConstraint.isActive = false
            leadingConstraint.isActive = true
        }
    }
}
