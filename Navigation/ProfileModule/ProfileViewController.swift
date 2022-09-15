//
//  SecondTabVC.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    private let changeTitleButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Change title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        setupConstraints()
        
        view.backgroundColor = .lightGray
        profileHeaderView.backgroundColor = .lightGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {

        view.addSubview(profileHeaderView)
        view.addSubview(changeTitleButton)

        NSLayoutConstraint.activate([

            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            changeTitleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            changeTitleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            changeTitleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
