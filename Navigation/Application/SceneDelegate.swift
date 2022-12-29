//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Aleksey on 30.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var musicTabNavigationController: UINavigationController!
    var feedTabNavigationController: UINavigationController!
    var logInTabNavigationController: UINavigationController!
    
    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        let logInVC = LogInViewController()
//        logInVC.logInDelegate = LogInInspector()  // для задачи №1
        logInVC.logInDelegate = MyLogInFactory().makeLogInInspector()
        logInTabNavigationController = UINavigationController.init(rootViewController: logInVC)
        
        musicTabNavigationController = UINavigationController.init(rootViewController: MusicPlayerViewController())
        
        feedTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        
        tabBarController.viewControllers = [logInTabNavigationController, feedTabNavigationController, musicTabNavigationController]
        
        let item1 = UITabBarItem(title: "Profile", image:  UIImage(systemName: "person.circle"), tag: 0)
        let item2 = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 1)
        let item3 = UITabBarItem(title: "Music", image: UIImage(systemName: "music.note.list"), tag: 2)
        
        logInTabNavigationController.tabBarItem = item1
        feedTabNavigationController.tabBarItem = item2
        musicTabNavigationController.tabBarItem = item3

        UITabBar.appearance().tintColor = UIColor(named: "AccentColor")
        UITabBar.appearance().backgroundColor = .systemBackground
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        
        appConfiguration = AppConfiguration.allCases.randomElement()

         if let configuration = appConfiguration {
             NetworkService.request(for: configuration)
         } else {
             print("Bad url to request")
         }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

