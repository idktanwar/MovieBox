//
//  MainTabController.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: Properties
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        guard let viewcontrollers = viewControllers else {
            return
        }
        
        for viewcontroller in viewcontrollers {
            if let movieNavConctroller = viewcontroller as? MovieItemNavigationController {
                if let movieItemController = movieNavConctroller.viewControllers.first as? ViewController {
                    movieItemController.title = "Movie Shows"
                }
            }
        }
    }
    
}
