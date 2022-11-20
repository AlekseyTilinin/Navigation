//
//  UserModel.swift
//  Navigation
//
//  Created by Aleksey on 26.10.2022.
//

import Foundation
import UIKit

protocol AppUser {
    
    var user : User {get set}
}

class User {
    
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(fullName: String, avatar: UIImage, status: String) {
        
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

class CurrentUserService: AppUser {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
}
    
class TestUserService: AppUser {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
}
