//
//  UserModel.swift
//  Navigation
//
//  Created by Aleksey on 26.10.2022.
//

import Foundation
import UIKit

protocol UserService {
    
    func authorization (logIn: String) -> User?
}

class User {
    
    var logIn: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(logIn: String, fullName: String, avatar: UIImage, status: String) {
        self.logIn = logIn
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

class CurrentUserService: UserService {
    
    let user: User
    
    func authorization(logIn: String) -> User? {
        if logIn == user.logIn {
            return user
        }
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
}
    
class TestUserService: UserService {
    
    let user: User
    
    func authorization(logIn: String) -> User? {
        if logIn == user.logIn {
            return user
        }
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
}
