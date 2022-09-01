//
//  SecondTabVC.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupConstraints()
        
        titleLabel.text = "Profile"
        
        view.backgroundColor = .systemRed
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
       
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
        ])
        
    }
}
