//
//  Extensions.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 06/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let lightBlue1 = UIColor.rgb(red: 29, green: 161, blue: 242)
}
