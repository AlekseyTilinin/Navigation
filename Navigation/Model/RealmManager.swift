//
//  RealmManager.swift
//  Navigation
//
//  Created by Aleksey on 28.01.2023.
//

import Foundation
import RealmSwift

class RealmUser : Object {
    @Persisted var login : String?
    @Persisted var password: String?
    @Persisted var lastAuth: Double? = nil

    convenience init(login: String, password: String) {
           self.init()
           self.login = login
           self.password = password
       }
}
