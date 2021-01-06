//
//  ViewController.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 06/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchContoller: UISearchController!
    var currentMovieData: [String] = []
    var originalMovieData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        //TODO: getMovieData
        addMovieList(movieItme: 5, name: "X-Man")
        addMovieList(movieItme: 5, name: "Iron  Man")
        addMovieList(movieItme: 5, name: "Avengers")
        
        currentMovieData = originalMovieData
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
        self.navigationItem.titleView = imageView
        
        searchContoller = UISearchController(searchResultsController: nil)
        searchContoller.searchResultsUpdater = self
        searchContainerView.addSubview(searchContoller.searchBar)
        searchContoller.searchBar.delegate = self
    }
    
    //TODO: for test
    func addMovieList(movieItme: Int, name: String) {
        
        for index in 1...10 {
            originalMovieData.append("\(name) \(index)")
        }
    }

    //Filter Movie Data
    func filterMovieList(withSearchText searchTerm: String) {
        if searchTerm.count > 0 {
            
            //TODO: don't use the contains keyword for search. use boyer moore algorithm for  search criteria for more efficient search
            currentMovieData = originalMovieData
            let filterMovieList = currentMovieData.filter{ $0.replacingOccurrences(of: "", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
                
            }
            
            currentMovieData = filterMovieList
            tableView.reloadData()
        }
    }
    
    func restoreMovieList() {
        currentMovieData = originalMovieData
        tableView.reloadData()
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterMovieList(withSearchText: searchText)
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchContoller.isActive = false
        if let searchText = searchBar.text, !searchText.isEmpty {
            restoreMovieList()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchContoller.isActive = false
        if let searchText = searchBar.text {
            filterMovieList(withSearchText: searchText)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        originalMovieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell", for: indexPath) as! MovieItemCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Open detail view controller")
        
        let alertController = UIAlertController(title: "Selection", message: "Details for movie will soon available", preferredStyle: .alert)
        
        searchContoller.isActive = false
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180

        }
}


