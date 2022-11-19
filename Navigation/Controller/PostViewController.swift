//
//  PostViewController.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableCellIndentifier")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultTableCellIndentifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupConstraints()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showInfoViewController))
    
        }
        
        func setupConstraints() {
            view.addSubview(titleLabel)
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
           
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    
    @objc func showInfoViewController() {
        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true)
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return  publications.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCellIndentifier", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableCellIndentifier", for: indexPath)
            return cell
        }
        
        let post = publications[indexPath.row]
        
        let postViewModel = PostTableViewCell.Post(
            author: post.author,
            image: post.image,
            description: post.description,
            likes: "Likes: \(post.likes)",
            views: "Views: \(post.views)"
        )
        cell.setup(with: postViewModel)
        return cell
    }
}
