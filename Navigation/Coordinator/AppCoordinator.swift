//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Aleksey on 20.11.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var child: [Coordinator] = []
    weak var transitionHandler: UITabBarController?
    
    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }
    
    func start() {
        
        startFeedCoordinator()
        startProfileCoordinator()
    }
    
    func startFeedCoordinator() {
        let feedCoordinator = FeedCoordinator(transitionHandler: transitionHandler!)
        child.append(feedCoordinator)
        feedCoordinator.coordinator = self
        feedCoordinator.start()
    }
    
    func startProfileCoordinator() {
        let profileCoordinator = ProfileCoordinator(transitionHandler: transitionHandler!)
        child.append(profileCoordinator)
        profileCoordinator.coordinator = self
        profileCoordinator.start()
    }
}
