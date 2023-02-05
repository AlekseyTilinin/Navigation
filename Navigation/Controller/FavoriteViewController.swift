//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Aleksey on 31.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableCellIdentifier")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite post"
        view.backgroundColor = .white
        
        let clear = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        navigationItem.rightBarButtonItems = [clear]
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func clear() {
        CoreDataModel().delete()
        tableView.reloadData()
    }
}

extension FavoriteViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataModel().favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableCellIdentifier", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
            return cell
        }
        
        let post = CoreDataModel().favoritePosts[indexPath.row]
        
        let postViewModel = PostTableViewCell.Post (
            postId: indexPath.row,
            postAuthor: post.author!,
            postImage: post.image!,
            postDescription: post.description,
            postLikes: "Likes: \(post.likes)",
            postViews: "Views: \(post.views)"
        )
        cell.setup(with: postViewModel)
        return cell
        
    }
}
