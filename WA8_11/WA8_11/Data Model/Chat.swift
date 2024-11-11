//
//  Chat.swift
//  WA8_11
//
//  Created by Kidus Yohannes on 11/11/24.
//

import Foundation
//import FirebaseFirestore

struct Chat: Codable{
    //@DocumentID var id: String?
    var name: String
    var text: String
    var date: Date
    
    init(name: String, text: String, date: Date) {
        self.name = name
        self.text = text
        self.date = date
    }
}
