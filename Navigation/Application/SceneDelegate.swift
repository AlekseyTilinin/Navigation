//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Aleksey on 30.08.2022.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var musicTabNavigationController: UINavigationController!
    var feedTabNavigationController: UINavigationController!
    var loginTabNavigationController: UINavigationController!
    
    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        let loginVC = LoginViewController()
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
        loginTabNavigationController = UINavigationController.init(rootViewController: loginVC)
        
        musicTabNavigationController = UINavigationController.init(rootViewController: MusicPlayerViewController())
        
        feedTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        
        tabBarController.viewControllers = [loginTabNavigationController, feedTabNavigationController, musicTabNavigationController]
        
        let item1 = UITabBarItem(title: "Profile", image:  UIImage(systemName: "person.circle"), tag: 0)
        let item2 = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 1)
        let item3 = UITabBarItem(title: "Music", image: UIImage(systemName: "music.note.list"), tag: 2)
        
        loginTabNavigationController.tabBarItem = item1
        feedTabNavigationController.tabBarItem = item2
        musicTabNavigationController.tabBarItem = item3

        UITabBar.appearance().tintColor = UIColor(named: "AccentColor")
        UITabBar.appearance().backgroundColor = .systemBackground
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        
        appConfiguration = AppConfiguration.title

         if let configuration = appConfiguration {
             NetworkService.request(for: configuration)
         } else {
             print("Bad url to request")
         }
        
        appConfiguration = AppConfiguration.planets

         if let configuration = appConfiguration {
             NetworkService.request(for: configuration)
         } else {
             print("Bad url to request")
         }
        
        let config = Realm.Configuration(
                    schemaVersion: 2)
                Realm.Configuration.defaultConfiguration = config

                let realm = try! Realm()

                let todos = realm.objects(RealmUser.self)
                print("❗️\(todos)")
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

