//
//  InfoViewController.swift
//  Navigation
//
//  Created by Aleksey on 01.09.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Show Alert", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let alertController = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupAlertConfiguration()
        setupConstraints()
        addTargets()
        
        view.backgroundColor = .orange
    }
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
           print("Alert")
        }))
        alertController.addAction(UIAlertAction(title: "OKK", style: .default, handler: { _ in
            print("Alert")
        }))
    }
    
    func addTargets() {
        button.addTarget(self, action: #selector(addTarget), for: .touchUpInside)
    }
    
    func setupConstraints() {

        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
    }
    
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
    }
    
}
