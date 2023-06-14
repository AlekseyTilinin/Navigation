//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Aleksey on 28.05.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {

    let context = LAContext()
    let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics

    var error: NSError?

    var type: LABiometryType = .none

    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        let result = context.canEvaluatePolicy(policy, error: &error)

        if result {
            context.evaluatePolicy(policy, localizedReason: "Verify your Identity") { result, error in
                authorizationFinished(result, error)
            }
        } else {
            print("Биометрия отключена")
        }

    }
}
