//
//  FirstTabNavigationController.swift
//  Navigation
//
//  Created by Aleksey on 31.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var showSomePostButton: CustomButton = CustomButton(title: String(localized: "showSomePostButtonTitle"))
    
    private lazy var showNewPostButton: CustomButton = CustomButton(title: String(localized: "showNewPostButtonTitle"))
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.clearButtonMode = .whileEditing
        textField.setPaddingPoints(15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = CustomButton(title: String( localized: "checkGuessButtonTitle"))
    
    private lazy var resultIndicator: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        buttonsActions()
        view.backgroundColor = .systemBackground
    }
    
    func buttonsActions() {
        
        showSomePostButton.buttonAction = {
            let postViewController = PostViewController()
            self.navigationController?.pushViewController(postViewController, animated: true)
        }
        
        showNewPostButton.buttonAction = {
            let infoViewController = InfoViewController()
            self.navigationController?.present(infoViewController, animated: true)
        }
        
        checkGuessButton.buttonAction = { [self] in
            let check: Bool = FeedModel().check(word: self.textField.text!)
            if check == true {
                resultIndicator.backgroundColor = .green
                resultIndicator.text = String(localized: "resultSuccess")
            } else {
                resultIndicator.backgroundColor = .red
                resultIndicator.text = String(localized: "resultFail")
            }
        }
    }
    
    func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(showSomePostButton)
        stackView.addArrangedSubview(showNewPostButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(resultIndicator)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomization()
    }
    
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
        navigationController?.navigationBar.tintColor = .brown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = String(localized: "feedNavigationTitle")
    }
}


