//
//  UIColorExtention.swift
//  Navigation
//
//  Created by Aleksey on 07.04.2023.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {guard #available(iOS 13.0, *) else {
        return lightMode
    }
        return UIColor { (traitCollection) -> UIColor in return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

let colorMainBackground: UIColor = UIColor.createColor(lightMode: .white, darkMode: .black)
let colorSecondaryBackground: UIColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray4)
let colorBorder: UIColor = UIColor.createColor(lightMode: .systemGray, darkMode: .white)
let colorText: UIColor = UIColor.createColor(lightMode: .black, darkMode: .white)


let colorTabBarMainBackground = UIColor.createColor(lightMode:  .systemBackground, darkMode: .black)
let colorTabBarTint = UIColor.createColor(lightMode:  UIColor(named: "AccentColor") ?? .systemBlue, darkMode: .white)
