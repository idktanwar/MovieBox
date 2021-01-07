//
//  MovieListController.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class MovieListController: UIViewController {
    
    //    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchContoller: UISearchController!
    private var viewModel = MovieViewModel()
    var test: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        //get movie data
        loadNewMoviesData()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
    }
    
    func configureUI() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        //        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.lightBlue1
        self.navigationItem.title = "MovieBox"
        
    }
    
    private func loadNewMoviesData() {
        viewModel.fetchNewMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}

    //extension ViewController: UISearchResultsUpdating {
    //    func updateSearchResults(for searchController: UISearchController) {
    //        if let searchText = searchController.searchBar.text {
    //            filterMovieList(withSearchText: searchText)
    //        }
    //    }
    //
    //}
    //
    //extension ViewController: UISearchBarDelegate {
    //    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //        searchContoller.isActive = false
    //        if let searchText = searchBar.text, !searchText.isEmpty {
    //            restoreMovieList()
    //        }
    //    }
    //
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        searchContoller.isActive = false
    //        if let searchText = searchBar.text {
    //            filterMovieList(withSearchText: searchText)
    //        }
    //    }
    //}


//Implement pagination after the basic view
extension MovieListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell", for: indexPath) as! MovieItemCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)

        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}


