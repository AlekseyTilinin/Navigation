//
//  CustomButton.swift
//  Navigation
//
//  Created by Aleksey on 13.11.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var buttonAction: () throws -> Void = {}
    
    init (title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() throws {
        try buttonAction()
    }
}
