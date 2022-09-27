//
//  FirstTabNavigationController.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let showSomePostButton: UIButton = {
       let button = UIButton()
        button.setTitle("Show some post", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let showNewPostButton: UIButton = {
       let button = UIButton()
        button.setTitle("Show new post", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupConstraints()
        addTargets()
        view.backgroundColor = .lightGray
    }
    
    func addTargets() {
        showSomePostButton.addTarget(self, action: #selector(showPostViewController), for: .touchUpInside)
        showNewPostButton.addTarget(self, action: #selector(showPostViewController), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(showSomePostButton)
        stackView.addArrangedSubview(showNewPostButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
            navigationController?.navigationBar.isHidden = true
            self.navigationItem.title = "Feed"
        }
    
    @objc func showPostViewController() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
}


