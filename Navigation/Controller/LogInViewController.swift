//
//  LogInViewController.swift
//  Navigation
//
//  Created by Aleksey on 26.09.2022.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
#if DEBUG
    var userLogin: TestUserService?
#else
    var userLogin: CurrentUserService?
#endif
    
    var loginDelegate: LoginViewControllerDelegate?
    
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
    
    private lazy var loginTextField: UITextField = {
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
        textField.keyboardType = .emailAddress
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
    
    private lazy var loginButton: CustomButton = CustomButton(title: "Login")
    private lazy var registrationButton: CustomButton = CustomButton(title: "Registration")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.buttonPressed()
        self.addViews()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
#if DEBUG
        userLogin = TestUserService(user: User(fullName: "Test Test", avatar: UIImage(), status: "Test"))
#else
        userLogin = CurrentUserService(user: User(fullName: "Surprised Cat", avatar: UIImage(named: "SurprisedCat")!, status: "I'm surprised!"))
#endif

        let realm = try! Realm()
        let users = realm.objects(RealmUser.self)
        let user = users.where {
                    $0.login == UserDefaults.standard.string(forKey: "userLogin")
                }

        if !user.isEmpty {
            if user[0].lastAuth != nil {
                let profileViewController = ProfileViewController()
                profileViewController.user = userLogin!.user
                self.navigationController?.pushViewController(profileViewController, animated: true)
            }
        }
        
        if loginButton.isHighlighted || loginButton.isSelected || !loginButton.isEnabled { loginButton.alpha = 0.8 }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func buttonPressed() {
        
        loginButton.buttonAction = { [self] in
            
            let enteredLogin = loginTextField.text!
            let enteredPassword = passwordTextField.text!
            
            Checker().checkCredentials(login: enteredLogin, password: enteredPassword) { result in
                if result == "Success authorization" {
                    
                    let realm = try! Realm()
                    let users = realm.objects(RealmUser.self)
                    let user = users.where {
                        $0.login == enteredLogin && $0.password == enteredPassword
                    }
                
                    try! realm.write {
                        user[0].lastAuth = NSDate().timeIntervalSince1970
                        UserDefaults.standard.set(user[0].login, forKey: "userLogin")
                    }
                    
                    let profileViewController = ProfileViewController()
                    profileViewController.user = self.userLogin!.user
                    self.navigationController?.pushViewController(profileViewController, animated: true)
                    
                } else if result == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.alertRegistration(message: result)
                } else {
                    self.alertBadPassword(message: result)
                }
            }
        }
    
        
        registrationButton.buttonAction = { [self] in
            
            let enteredLogin = loginTextField.text!
            let enteredPassword = passwordTextField.text!
            
            Checker().checkCredentials(login: enteredLogin, password: enteredPassword) { result in
                if result == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.alertBadLogin(message: result) { result in
                        Checker().signUp(login: enteredLogin, password: enteredPassword) { result in
                            if result == "Success registration" {
                                self.alertSuccess(message: result)
                                
                                let realm = try! Realm()
                                let newUser = RealmUser(login: enteredLogin, password: enteredPassword)
                              
                                try! realm.write {
                                    realm.add(newUser)
                                }
                                
                                let profileViewController = ProfileViewController()
                                profileViewController.user = self.userLogin!.user
                                self.navigationController?.pushViewController(profileViewController, animated: true)
                            } else {
                                self.alertBadPassword(message: result)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func alertBadPassword(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertSuccess(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertBadLogin(message: String, complition: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Error", message: "Do you want to register new user?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { action in
            complition(true)
        })
        alert.addAction(UIAlertAction(title: "No", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertRegistration(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
        
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func addViews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.loginTextField)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.scrollView.addSubview(self.loginButton)
        self.scrollView.addSubview(self.registrationButton)
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
            
            self.stackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 100),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.loginButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.registrationButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 16),
            self.registrationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.registrationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.registrationButton.frame.origin.y + self.registrationButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16 : 0
            
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
