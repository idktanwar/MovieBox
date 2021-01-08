//
//  SearchViewController.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 08/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: Properties
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        searchController =  UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.title = "Search Movie"
    }
}
