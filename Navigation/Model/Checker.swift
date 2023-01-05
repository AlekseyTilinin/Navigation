//
//  Checker.swift
//  Navigation
//
//  Created by Aleksey on 04.11.2022.
//

import Foundation
import UIKit
import FirebaseAuth

//protocol LoginViewControllerDelegate {
//
//    func checkCregential(_ sender: LoginViewController, login: String, password: String)
//    func signUp(_ sender: LoginViewController, login: String, password: String)
//}

protocol LoginViewControllerDelegate {

    func checkCredentials(login: String, password: String, complition: @escaping (String) -> Void)
    func signUp(login: String, password: String, complition: @escaping (String) -> Void)
}

class Checker: LoginViewControllerDelegate {
    
    func checkCredentials(login: String, password : String, complition: @escaping (String) -> Void) {
        
        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let res = result {
                    complition(res)
                }
            } else {
                complition("Success authorization")
            }
        }
        
    }
    
    func signUp(login: String, password : String, complition: @escaping (String) -> Void) {
        
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let result = error?.localizedDescription as? String
                if let res = result {
                    complition(res)
                }
            } else {
                complition("Success registration")
            }
        }
    }
}

protocol LoginFactory {

    func makeLoginInspector() -> Checker
}

struct MyLoginFactory: LoginFactory {

    func makeLoginInspector() -> Checker {
        return Checker()
    }
}
