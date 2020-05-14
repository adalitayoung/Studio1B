//
//  styles.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 20/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
import Foundation
import UIKit

enum Color {
    static let black = UIColor.black
    static let tint = UIColor.green
}

enum Alpha {
    static let none     = CGFloat(0.0)
    static let veryLow  = CGFloat(0.05)
    static let low      = CGFloat(0.30)
    static let medium1  = CGFloat(0.40)
    static let medium2  = CGFloat(0.50)
    static let medium3  = CGFloat(0.60)
    static let high     = CGFloat(0.87)
    static let full     = CGFloat(1.0)
}

enum Font {
    static func withSize(_ size: CGFloat, weight: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight))
    }
}

extension TextStyle {
    
    static let body = TextStyle(
        font: Font.withSize(15.0, weight: UIFont.Weight.regular.rawValue),
        color: Color.black
    )
    
    static let title = TextStyle(
        font: Font.withSize(20.0, weight: UIFont.Weight.light.rawValue),
        color: Color.black
    )
}

extension TextStyle {
    
    enum Button {
        static let action = TextStyle(
            font: Font.withSize(16.0, weight: UIFont.Weight.medium.rawValue),
            color: Color.tint
        )
    }
}
