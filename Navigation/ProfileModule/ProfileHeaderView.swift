//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Aleksey on 13.09.2022.

import UIKit

class ProfileHeaderView: UIView {
    
    var statusText: String = ""
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SurprisedCat")
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surprised Cat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = label.font.withSize(14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter status"
        textField.setPaddingPoints(10)
        textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func addTargets() {
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    
    func addGestures() {
        let avatrTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.avatarTapGesture(_:)))
        self.avatarImageView.addGestureRecognizer(avatrTapGestureRecognizer)
    }
    
    func addNotofication(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCloseClick(notification:)),
                                               name: Notification.Name("closeClick!"),
                                               object: nil)
    }
    
    override func draw(_ rect: CGRect) {
        
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        self.addTargets()
        self.addGestures()
        self.addNotofication()
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -10),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            statusLabel.heightAnchor.constraint(equalToConstant: 15),
            
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor,constant: -34),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 19),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text!
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
        statusLabel.textColor = .black
        statusTextField.resignFirstResponder()
        statusTextField.text = ""
    }
    
    @objc func avatarTapGesture(_ gestureReconizer: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name("avatarClick!"), object: nil)
    }
    
    @objc func didCloseClick(notification: Notification) {
        avatarImageView.isHidden = false
    }
}
