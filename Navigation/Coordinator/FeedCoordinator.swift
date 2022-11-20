//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Aleksey on 20.11.2022.
//

import UIKit

class FeedCoordinator: Coordinator {
    
    var child: [Coordinator] = []
    weak var transitionHandler: UITabBarController?
    weak var coordinator: AppCoordinator?
    
    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }
    
    func start() {
        showFeedScreen()
    }
    
    func showFeedScreen() {
        let viewController = FeedViewController()
        viewController.coordinator = self
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.tabBarItem = TabBarItems[0]
        transitionHandler?.viewControllers = [navigationController]
    }
    
    func showPostScreen(navigationController: UINavigationController) {
        let viewController = PostViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showInfoScreen(sender: UIViewController) {
        let viewController = InfoViewController()
        viewController.modalPresentationStyle = .pageSheet
        sender.present(viewController, animated: true, completion: nil)
    }
}
