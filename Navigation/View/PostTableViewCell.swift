//
//  PostTableHeaderCell.swift
//  Navigation
//
//  Created by Aleksey on 28.09.2022.
//

import UIKit
import CoreData

class PostTableViewCell: UITableViewCell {
    
    var postId: Int = 0
    var imagePost: String = ""
    var likesPost: Int = 0
    var viewsPost: Int = 0
    
    struct Post {
        var postId: Int
        var postAuthor: String
        var postImage: String
        var postDescription: String
        var postLikes: Int
        var postViews: Int
    }
    
    private lazy var postAuthor: UILabel = {
        let label = UILabel()
        label.text = "postAuthor"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "first_post")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var postDescription: UILabel = {
        let description = UILabel()
        description.text = "postDescription"
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 14)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var postLikes: UILabel = {
        let likes = UILabel()
        likes.text = "postLikes"
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var postViews: UILabel = {
        let views = UILabel()
        views.text = "postViews"
        views.font = UIFont.systemFont(ofSize: 16)
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addToFavotire(_:)))
                 tap.numberOfTapsRequired = 2
                 self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with post: Post) {
        self.postAuthor.text = post.postAuthor
        self.postDescription.text = post.postDescription
        self.postImage.image = UIImage(named: "\(post.postImage)")
//        self.postLikes.text = "Likes: \(post.postLikes)"
        self.postViews.text = "Views: \(post.postViews)"
        let formattedString = NSLocalizedString("likesCount", comment: "")
        let string = String(format: formattedString, Int(post.postLikes))
        self.postLikes.text = string
        
        self.postId = post.postId
        self.imagePost = post.postImage
        self.likesPost = post.postLikes
        self.viewsPost = post.postViews
    }
    
    private func setupView() {
        self.contentView.addSubview(self.postAuthor)
        self.contentView.addSubview(self.postDescription)
        self.contentView.addSubview(self.postImage)
        self.contentView.addSubview(self.postLikes)
        self.contentView.addSubview(self.postViews)
        
        NSLayoutConstraint.activate([
            self.postAuthor.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.postAuthor.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.postAuthor.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.postImage.topAnchor.constraint(equalTo: self.postAuthor.bottomAnchor, constant: 12),
            self.postImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            self.postImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            self.postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            self.postDescription.topAnchor.constraint(equalTo: self.postImage.bottomAnchor, constant: 16),
            self.postDescription.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.postDescription.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            self.postLikes.topAnchor.constraint(equalTo: self.postDescription.bottomAnchor, constant: 16),
            self.postLikes.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
                        
            self.postViews.topAnchor.constraint(equalTo: self.postDescription.bottomAnchor, constant: 16),
            self.postViews.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),

            self.contentView.bottomAnchor.constraint(equalTo: self.postViews.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func addToFavotire(_ sender: UITapGestureRecognizer) {

             let posts = CoreDataModel().getPosts()
             var postIndexes: [Int] = []

             if posts.isEmpty {
                 print("post is empty")
                 CoreDataModel().addToFavorite(postId: postId, author: postAuthor.text!, descr: postDescription.text!, likes: likesPost, views: viewsPost, image: imagePost)
             } else {
                 for p in posts {
                     postIndexes.append(Int(p.postId))
                 }

                 if let index = postIndexes.firstIndex(of: postId) {
                     print("Post-\(index) already in favorite")

                 } else {
                     CoreDataModel().addToFavorite(postId: postId, author: postAuthor.text!, descr: postDescription.text!, likes: likesPost, views: viewsPost, image: imagePost)
                 }
             }

         }
}
