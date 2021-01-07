//
//  Helper.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static var app: Helper = {
        return Helper()
    }()
    
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }

    static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
//        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .default);
//        vc.presentViewController(alert, animated: true, completion: nil)
    }
}


protocol videoPlayDelegate: class {
    func playvideo(atCell: Int)
}


