//
//  InfoViewController.swift
//  Navigation
//
//  Created by Aleksey on 01.09.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = infoTitle.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: CustomButton = CustomButton(title: "Show Alert")
    
    private lazy var alertController = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupButtonAndAlert()
        setupConstraints()
    }
    
    func setupButtonAndAlert() {
        button.buttonAction = { [self] in
            present(alertController, animated: true, completion: nil)
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
           print("Alert")
        }))
        alertController.addAction(UIAlertAction(title: "OKK", style: .default, handler: { _ in
            print("Alert")
        }))
    }
    
    func setupConstraints() {

        view.addSubview(button)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
