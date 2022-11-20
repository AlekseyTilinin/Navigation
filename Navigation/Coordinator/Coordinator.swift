//
//  Coordinator.swift
//  Navigation
//
//  Created by Aleksey on 20.11.2022.
//

import UIKit

protocol Coordinator : AnyObject {
    var child : [Coordinator] { get set}
}
