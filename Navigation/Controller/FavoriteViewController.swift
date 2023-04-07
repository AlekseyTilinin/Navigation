//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Aleksey on 31.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var coreDataModel = CoreDataModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
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
        self.title = String(localized: "favoriteNavigationTitle")
        view.backgroundColor = colorMainBackground
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        let clear = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        navigationItem.rightBarButtonItems = [clear, search]
        
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
        coreDataModel.getPosts()
        tableView.reloadData()
    }
    
    @objc func search() {
        showInputDialog(title: String(localized: "searchTitle"), actionHandler:  { text in
            if let result = text {
                self.coreDataModel.getResults(query: result)
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func clear() {
        coreDataModel.getPosts()
        tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataModel.favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: String(localized: "deleteContextualAction")) { (action, swipeButtonView, completion) in
            self.coreDataModel.deleteFromFavorite(index: indexPath.row)
            self.coreDataModel.getPosts()
            self.tableView.reloadData()
            completion(true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableCellIdentifier", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
            return cell
        }
        
        let post = coreDataModel.favoritePosts[indexPath.row]
        
        let postViewModel = PostTableViewCell.Post (
            postId: indexPath.row,
            postAuthor: post.author!,
            postImage: post.image!,
            postDescription: post.descr!,
            postLikes: Int(post.likes),
            postViews: Int(post.views)
        )
        cell.setup(with: postViewModel)
        return cell
        
    }
}

extension UIViewController {
     func showInputDialog(title: String? = nil,
                          subtitle: String? = nil,
                          actionTitle: String? = String(localized: "showInputDialogActionTitle"),
                          cancelTitle: String? = String(localized: "showInputDialogCancelTitle"),
                          inputPlaceholder: String? = nil,
                          inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                          cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                          actionHandler: ((_ text: String?) -> Void)? = nil) {

         let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
         alert.addTextField { (textField:UITextField) in
             textField.placeholder = inputPlaceholder
             textField.keyboardType = inputKeyboardType
         }
         alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action: UIAlertAction) in
             guard let textField =  alert.textFields?.first else {
                 actionHandler?(nil)
                 return
             }
             actionHandler?(textField.text)
         }))
         alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))

         self.present(alert, animated: true, completion: nil)
     }
 }
