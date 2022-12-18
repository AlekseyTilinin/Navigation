//
//  Extensions.swift
//  Navigation
//
//  Created by Aleksey on 27.09.2022.
//

import Foundation
import UIKit

extension UITextField {
    func setPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}






