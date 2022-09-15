//
//  SecondTabVC.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        //setupConstraints()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(profileHeaderView)
        
    }
    
//    func setupConstraints() {
//
//        view.addSubview(profileHeaderView)
//
//        NSLayoutConstraint.activate([
//
//            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//
//        ])
//    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        profileHeaderView.frame = view.frame

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navBarCustomization()
        }
        
        func navBarCustomization () {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
            navigationController?.navigationBar.tintColor = .brown
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationItem.title = "Profile"
        }
    
}
