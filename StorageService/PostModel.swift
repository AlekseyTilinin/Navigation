//
//  Post.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

public struct Post {
    public var author: String
    public var image: UIImage?
    public var description: String
    public var likes: Int
    public var views: Int
}

public var publications: [Post] = [
    Post(author: "Surprised cat", image: UIImage(named: "first_post"), description: "My first publication", likes: 3, views: 24),
    Post(author: "Surprised cat", image: UIImage(named: "second_post"), description: "My second publication", likes: 5, views: 98),
    Post(author: "Surprised cat", image: UIImage(named: "third_post"), description: "My third publication", likes: 7, views: 45),
    Post(author: "Surprised cat", image: UIImage(named: "fourth_post"), description: "My fourth publication", likes: 3, views: 20),
]
