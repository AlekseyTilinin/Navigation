//
//  PostTableHeaderCell.swift
//  Navigation
//
//  Created by Aleksey on 28.09.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct Post {
        var author: String
        var image: UIImage?
        var description: String
        var likes: String
        var views: String
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func setup(with post: Post) {
            self.postAuthor.text = post.author
            self.postDescription.text = post.description
            self.postImage.image = post.image
            self.postLikes.text = post.likes
            self.postViews.text = post.views
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
}
