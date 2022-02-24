//
//  User.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/11/22.
//

import Foundation
import UIKit
class User: Decodable {
    let id: Int
    let email, first_name, last_name, avatar: String
    
    init(id: Int, fname: String, lName: String, email: String) {
        self.id = id
        self.first_name = fname
        self.last_name = lName
        self.avatar = "https://www.planetware.com/photos-large/I/italy-colosseum-day.jpg"
        self.email = email
        
    }
}

class Single: Decodable {
    
    let data: User
    
    
}

class Result: Decodable {
    let total: Int 
    let data: [User]
   
    
}

