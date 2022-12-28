//
//  Checker.swift
//  Navigation
//
//  Created by Aleksey on 04.11.2022.
//

import Foundation
import UIKit

protocol LogInViewControllerDelegate {
    
    func check(_ sender: LogInViewController, logIn: String, password: String) -> Bool
}

class Checker {
    
    static let shared = Checker()
    
    private init() {
        logIn = ""
        password = ""
    }
    
    private let logIn: String
    private let password: String
    
    func check(logIn: String, password: String) -> Bool {
        self.logIn == logIn && self.password == password
    }
}

struct LogInInspector: LogInViewControllerDelegate {
    
    func check(_ sender: LogInViewController, logIn: String, password: String) -> Bool {
        return Checker.shared.check(logIn: logIn, password: password)
    }
}

protocol LogInFactory {
    
    func makeLogInInspector() -> LogInInspector
}

struct MyLogInFactory: LogInFactory {
    
    func makeLogInInspector() -> LogInInspector {
        return LogInInspector()
    }
}
