//
//  SecondTabVC.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    var user: User = User(fullName: "", avatar: UIImage(), status: "")
    
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
    
    private lazy var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hiddenAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SurprisedCat")
        image.isUserInteractionEnabled = true
        image.isHidden = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var hiddenCloseView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.tintColor = .white
        image.isUserInteractionEnabled = true
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEBUG
        view.backgroundColor = .systemYellow
#else
        view.backgroundColor = .systemBackground
#endif
        
        addViews()
        addConstraints()
        addGestures()
        addNotification()
    }
    
    private func addGestures() {
        let avatrTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.avatarTapGesture))
        self.hiddenAvatar.addGestureRecognizer(avatrTapGestureRecognizer)
        
        let closeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapCloseGesture))
        self.hiddenCloseView.addGestureRecognizer(closeTapGestureRecognizer)
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAvatarClick(notification:)),
                                               name: Notification.Name("avatarClick!"),
                                               object: nil)
    }
    
    private func addViews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.hiddenView)
        self.view.addSubview(self.hiddenAvatar)
        self.view.addSubview(self.hiddenCloseView)
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.hiddenView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.hiddenView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.hiddenView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.hiddenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.hiddenAvatar.topAnchor.constraint(equalTo: self.hiddenView.topAnchor, constant: 16),
            self.hiddenAvatar.leftAnchor.constraint(equalTo: self.hiddenView.leftAnchor, constant: 16),
            self.hiddenAvatar.widthAnchor.constraint(equalToConstant: 100),
            self.hiddenAvatar.heightAnchor.constraint(equalToConstant: 100),
            
            self.hiddenCloseView.topAnchor.constraint(equalTo: self.hiddenView.topAnchor, constant: 16),
            self.hiddenCloseView.rightAnchor.constraint(equalTo: self.hiddenView.rightAnchor, constant: -16),
            self.hiddenCloseView.widthAnchor.constraint(equalToConstant: 25),
            self.hiddenCloseView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func showAnimation() {
        
        let scalableCoef = self.hiddenView.frame.width / self.hiddenAvatar.frame.width
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            
            self.hiddenView.isHidden = false
            self.hiddenAvatar.isHidden = false
            
            self.hiddenAvatar.center = self.hiddenView.center
            self.hiddenAvatar.transform = CGAffineTransform(scaleX: scalableCoef, y: scalableCoef)
            self.hiddenAvatar.isUserInteractionEnabled = false
            
            self.hiddenView.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.hiddenCloseView.isHidden = false
            })
        }
    }
    
    private func closeAnimation() {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            
            self.hiddenAvatar.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.hiddenAvatar.center = CGPoint(x: 66, y: 86)
            self.hiddenView.alpha = 0
            self.hiddenCloseView.isHidden = true
            self.hiddenAvatar.isUserInteractionEnabled = true
        } completion: { _ in
            NotificationCenter.default.post(name: Notification.Name("closeClik!"), object: nil)
            self.hiddenAvatar.isHidden = true
        }
    }
    
    @objc func didAvatarClick(notification: Notification) {
        showAnimation()
    }
    
    @objc func avatarTapGesture(_gestureRecognizer: UITapGestureRecognizer) {
        showAnimation()
    }
    
    @objc func tapCloseGesture(_gestureRecognizer: UITapGestureRecognizer) {
        closeAnimation()
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let userProfile = ProfileHeaderView()
            userProfile.setup(user: user)
            return userProfile
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            return  publications.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return PhotosTableViewCell()
        } else if indexPath.section == 1 {
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
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "DefaultTableCellIndentifier", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        }
        return UITableView.automaticDimension
    }
}
