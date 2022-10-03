//
//  LogInViewController.swift
//  Navigation
//
//  Created by Aleksey on 26.09.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var logInTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textField.layer.borderWidth = 0.5
        textField.placeholder = "Введите логин"
        textField.clearButtonMode = .whileEditing
        textField.setPaddingPoints(15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.placeholder = "Введите пароль"
        textField.clearButtonMode = .whileEditing
        textField.setPaddingPoints(15)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.addTargets()
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.logInTextField)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.scrollView.addSubview(self.logInButton)
        let scrollViewConstraints = self.scrollViewConstraints()
        let logoImageViewConstraints = self.logoImageViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        let logInButtonConstraints = self.logInButtonConstraints()
        NSLayoutConstraint.activate(
            scrollViewConstraints +
            logoImageViewConstraints +
            stackViewConstraints +
            logInButtonConstraints
        )
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func addTargets() {
        logInButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        logInButton.alpha = logInButton.isEnabled ? 1 : 0.8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingAnchor = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
    
    private func logoImageViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.logoImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120)
        let centerXAnchor = self.logoImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let widthAnchor = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let heightAnchor = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        
        return [
            topAnchor, centerXAnchor, widthAnchor, heightAnchor
        ]
    }
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.stackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120)
        let leadingAnchor = self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingAnchor = self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightAnchor = self.stackView.heightAnchor.constraint(equalToConstant: 100)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, heightAnchor
        ]
    }
    
    private func logInButtonConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16)
        let leadingAnchor = self.logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingAnchor = self.logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightAnchor = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, heightAnchor
        ]
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let logInButtonBottomPointY = self.logInButton.frame.origin.y + self.logInButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < logInButtonBottomPointY
            ? logInButtonBottomPointY - keyboardOriginY + 16 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    @objc func buttonPressed() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        logInButton.alpha = logInButton.isHighlighted || logInButton.isSelected ? 0.8 : 1
    }
}


