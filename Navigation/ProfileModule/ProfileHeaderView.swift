//
//  ProfileHeadrView.swift
//  Navigation
//
//  Created by Aleksey on 08.09.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var statusText: String = ""
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 19, y: 107, width: 150, height: 150))
        imageView.image = UIImage(named: "SurprisedCat")
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLable: UILabel = {
       let lable = UILabel(frame: CGRect(x: 200, y: 115, width: 150, height: 20))
        lable.text = "Surprised Cat"
        lable.font = UIFont.boldSystemFont(ofSize: 18)
        lable.textColor = .black
        return lable
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 195, y: 195, width: 220, height: 15))   /*frame: (x: 200, y:227)*/
        label.text = "Waiting for something..."
        label.font = label.font.withSize(14)
        label.textColor = .gray
        //nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 190, y: 220, width: 180, height: 40))
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
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 276, width: 355, height: 50))
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
        myTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        self.addSubview(imageView)
        self.addSubview(nameLable)
        self.addSubview(statusLabel)
        self.addSubview(myTextField)
        self.addSubview(button)
        self.addTargets()
        
//        NSLayoutConstraint.activate([
//
//            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            imageView.widthAnchor.constraint(equalToConstant: 150),
//            imageView.heightAnchor.constraint(equalToConstant: 150),
//
//            nameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
//            nameLable.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
//            nameLable.widthAnchor.constraint(equalToConstant: 150),
//            nameLable.heightAnchor.constraint(equalToConstant: 20)
//
//
//
//        ])
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = myTextField.text!
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
        statusLabel.textColor = .black
        myTextField.resignFirstResponder()
        myTextField.text = ""
        //print(statusLabel.text!)
    }
}

extension UITextField {
    func setPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        //self.rightView = leftPaddingView
        self.leftViewMode = .always
        //self.rightViewMode = .always
    }
}
