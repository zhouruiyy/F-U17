//
//  UIColorExtension.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/11.
//

import UIKit

extension UIColor {
    convenience init(r: UInt32, g: UInt32, b:UInt32, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256), g: arc4random_uniform(256), b: arc4random_uniform(256))
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
