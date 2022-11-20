//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Aleksey on 20.11.2022.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var child: [Coordinator] = []
    weak var transitionHandler: UITabBarController?
    weak var coordinator: AppCoordinator?
    
    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }
    
    func start() {
        showLogInScreen()
    }
    
    func showLogInScreen() {
        let viewController = LogInViewController()
        viewController.coordinator = self
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.tabBarItem = TabBarItems[1]
        transitionHandler?.viewControllers?.append(navigationController)
    }
    
    func showProfileScreen(transitionHandler: UINavigationController, user: AppUser) {
        let viewController = ProfileViewController()
        viewController.user = user.user
        transitionHandler.pushViewController(viewController, animated: true)
    }
}
