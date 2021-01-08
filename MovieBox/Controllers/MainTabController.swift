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
                if let movieItemController = movieNavConctroller.viewControllers.first as? MovieListController {
                    movieItemController.title = "MovieBox"
                }
            }
            else if let searchNavConctroller = viewcontroller as? SearchVCNavController {
                if let searchVCController = searchNavConctroller.viewControllers.first as? SearchViewController {
                    searchVCController.title = "Search"
                }
            }
        }
    }
    

    
}
