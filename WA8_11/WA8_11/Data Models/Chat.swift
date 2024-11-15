//
//  Chat.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/11/24.
//

import Foundation
import FirebaseFirestore

struct Chat {
    let sender: String
    let recipient: String
    let text: String
    let timestamp: Date
    
    init(sender: String, recipient: String, text: String, timestamp: Date) {
        self.sender = sender
        self.recipient = recipient
        self.text = text
        self.timestamp = timestamp
    }
}

struct DisplayChat: Codable {
    @DocumentID var id: String?
    let sender: String
    let text: String
    let timestamp: Date
    
    init(sender: String, text: String, timestamp: Date) {
        self.sender = sender
        self.text = text
        self.timestamp = timestamp
    }
}
