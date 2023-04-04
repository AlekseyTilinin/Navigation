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
    var favoriteTabNavigationController: UINavigationController!
    var mapTabNavigationController: UINavigationController!
    
    var appConfiguration: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        let loginVC = LoginViewController()
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
        loginTabNavigationController = UINavigationController.init(rootViewController: loginVC)
        
        musicTabNavigationController = UINavigationController.init(rootViewController: MusicPlayerViewController())
        
        feedTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        
        favoriteTabNavigationController = UINavigationController(rootViewController: FavoriteViewController())
        
        mapTabNavigationController = UINavigationController(rootViewController: MapViewController())
        
        tabBarController.viewControllers = [loginTabNavigationController,
                                            feedTabNavigationController,
                                            musicTabNavigationController,
                                            favoriteTabNavigationController,
                                            mapTabNavigationController]
        
        let item1 = UITabBarItem(title: String(localized: "firstTabBarTitle"), image:  UIImage(systemName: "person.circle"), tag: 0)
        let item2 = UITabBarItem(title: String(localized: "secondTabBarTitle"), image: UIImage(systemName: "newspaper"), tag: 1)
        let item3 = UITabBarItem(title: String(localized: "thirdTabBarTitle"), image: UIImage(systemName: "music.note.list"), tag: 2)
        let item4 = UITabBarItem(title: String(localized: "fouthTabBarTitle"), image: UIImage(systemName: "star"), tag: 4)
        let item5 = UITabBarItem(title: String(localized: "fifthTabBarTitle"), image: UIImage(systemName: "map"), tag: 5)
        
        loginTabNavigationController.tabBarItem = item1
        feedTabNavigationController.tabBarItem = item2
        musicTabNavigationController.tabBarItem = item3
        favoriteTabNavigationController.tabBarItem = item4
        mapTabNavigationController.tabBarItem = item5

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

//                let realm = try! Realm()
//
//                let todos = realm.objects(RealmUser.self)
//                print("❗️\(todos)")
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataModel().saveContext()
    }
}

