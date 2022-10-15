//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Aleksey on 13.09.2022.

import UIKit
import SnapKit

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
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surprised Cat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = label.font.withSize(14)
        label.textColor = .gray
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
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(150)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-20)
            make.height.equalTo(20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(statusTextField.snp.top).inset(-10)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-20)
            make.height.equalTo(15)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.bottom.equalTo(setStatusButton.snp.top).inset(-34)
            make.leading.equalTo(avatarImageView.snp.trailing).inset(-15)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-19)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
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
