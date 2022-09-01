//
//  PostViewController.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class PostViewController: UIViewController {
        
        var dataSource = Post(title: "Post")
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showInfoViewController))
    
        }
        
        func setupUI() {
            
            setupConstraints()
            titleLabel.text = dataSource.title
            view.backgroundColor = .magenta
        }
        
        func setupConstraints() {
            view.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
           
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            ])
        }
    @objc func showInfoViewController() {
        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true)
    }
    
}
