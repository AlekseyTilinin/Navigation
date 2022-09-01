//
//  FirstTabNavigationController.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var dataSource = FeedModel(title: "Feed", description: "")
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Show some post", for: .normal)
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
        
        titleLabel.text = dataSource.title
        descriptionLabel.text = dataSource.description
        
        view.backgroundColor = .white
    }
    
    func addTargets() {
        button.addTarget(self, action: #selector(showPostViewController), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
       
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc func showPostViewController() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
}


