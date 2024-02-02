//
//  Helper.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import Foundation
import UIKit
extension UIView {
    func addBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: UIScreen.main.bounds.width - 10, height: 2)
        bottomLine.backgroundColor = UIColor.systemGray6.cgColor
        
        self.layer.addSublayer(bottomLine)
    }
    
    func addShadowToView(left: CGFloat, bottom: CGFloat, color: UIColor, opacity: Float, shadowRadius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: left, height: bottom)
        layer.shadowRadius = shadowRadius
    }
    
    func addCornerRadius(radius: CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
}
