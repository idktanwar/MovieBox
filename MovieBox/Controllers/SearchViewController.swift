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
    @IBOutlet weak var tableView: UITableView!

    var searchContoller: UISearchController!
    var movieVM = MovieViewModel()

    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
    }

    func setupUI() {
        searchContoller =  UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchContoller
        navigationItem.title = "Search Movie"
        
        searchContoller.searchResultsUpdater = self
        searchContoller.searchBar.delegate = self
        tableView.delegate = self
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.count >= 3 {
            movieVM.searchMovie(withQuery: searchText) {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchContoller.isActive = false
        if let searchText = searchBar.text, searchText.count >= 3,!searchText.isEmpty {
            movieVM.searchMovie(withQuery: searchText) {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchContoller.isActive = false
        if let searchText = searchBar.text, searchText.count >= 3 {
            movieVM.searchMovie(withQuery: searchText) {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieVM.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = movieVM.cellForRowAt(indexPath: indexPath)
        cell.textLabel?.text = movie.title
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieVM.cellForRowAt(indexPath: indexPath)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        viewController.selectedMovie = movie
        viewController.movieID = movie.id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

