//
//  LogInViewController.swift
//  Navigation
//
//  Created by Aleksey on 26.09.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    var logInDelegate: LogInViewControllerDelegate?
    
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var logInButton: CustomButton = CustomButton(title: "Log In")
    
    private lazy var generatePasswordButton: CustomButton = CustomButton(title: "Generate password")
    
    let alertMessege = UIAlertController(title: "Error", message: "Введены некоректные данные", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.addButtonAction()
        self.addViews()
        self.addConstraints()
        
        alertMessege.addAction(UIAlertAction(title: "OK", style: .destructive))
    }
    
   private func addButtonAction() {
        
        logInButton.buttonAction = { [self] in
            let enteredLogIn = logInTextField.text
            let enteredPassword = passwordTextField.text
            
#if DEBUG
            let userLogIn = TestUserService(user: User(fullName: "Test Test", avatar: UIImage(), status: "Test"))
#else
            let userLogIn = CurrentUserService(user: User(fullName: "Surprised Cat", avatar: UIImage(named: "SurprisedCat")!, status: "I'm surprised!"))
#endif
            
            if logInDelegate?.check(self, logIn: enteredLogIn ?? "", password: enteredPassword ?? "") == true {
                let profileViewController = ProfileViewController()
                profileViewController.user = userLogIn.user
                navigationController?.pushViewController(profileViewController, animated: true)
            } else {
                self.present(alertMessege, animated: true, completion: nil)
            }
        }
        
        generatePasswordButton.buttonAction = { [self] in
            passwordTextField.text = nil
            generatePasswordButton.isEnabled = false
            generatePasswordButton.backgroundColor = .systemGray
            activityIndicator.startAnimating()
            
            var password: String {
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                return String((0..<4).map { _ in letters.randomElement()! })
        }
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.bruteForce(passwordToUnlock: password)
            }
        }
    }
    
    private func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
        
        DispatchQueue.main.async { [self] in
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            passwordTextField.isSecureTextEntry = false
            passwordTextField.text = password
            generatePasswordButton.isEnabled = true
            generatePasswordButton.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        }
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func addViews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.logInTextField)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.scrollView.addSubview(self.logInButton)
        self.scrollView.addSubview(self.generatePasswordButton)
        self.scrollView.addSubview(self.activityIndicator)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logoImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            self.stackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.generatePasswordButton.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 16),
            self.generatePasswordButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.generatePasswordButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.generatePasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            self.activityIndicator.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if logInButton.isHighlighted || logInButton.isSelected || !logInButton.isEnabled { logInButton.alpha = 0.8 }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let generatePasswordButtonBottomPointY = self.generatePasswordButton.frame.origin.y + self.generatePasswordButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < generatePasswordButtonBottomPointY
            ? generatePasswordButtonBottomPointY - keyboardOriginY + 16 : 0
            
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
}
