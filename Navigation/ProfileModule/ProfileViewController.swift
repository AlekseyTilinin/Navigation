//
//  SecondTabVC.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .systemBackground
        
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
