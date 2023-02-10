//
//  CoreDataModel.swift
//  Navigation
//
//  Created by Aleksey on 31.01.2023.
//

import Foundation
import CoreData
import UIKit


class CoreDataModel {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var favoritePosts: [Favorite] = []
    
    func getPosts() -> [Favorite] {
        let answer = Favorite.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(answer)
            favoritePosts = posts
            return favoritePosts
        } catch {
            print(error)
        }
        return []
    }
    
    init() {
        getPosts()
    }
    
    func delete() {
        let answer = Favorite.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(answer)
            let context = persistentContainer.viewContext
            for post in posts {
                context.delete(post)
            }
            saveContext()
        } catch {
            print(error)
        }
        
    }
    
    func addToFavorite(postId: Int, author: String, descr: String, likes: Int, views: Int, image: String) {
        let post = Favorite(context: persistentContainer.viewContext)
        post.postId = Int32(postId)
        post.author = author
        post.descr = descr
        post.likes = Int32(likes)
        post.views = Int32(views)
        post.image = image
        saveContext()
    }
}
