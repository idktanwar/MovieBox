//
//  MovieViewModel.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    private var apiService = WebService()
    private var newMovies = [Movie]()
    
    func fetchNewMoviesData(withoffset offset: Int, limit: Int, completion: @escaping () -> ()) {
        apiService.getNewMoviesData(withoffset: offset, limit: limit) {
            [weak self] (result) in
            
            switch result {
                case .success(let listOf):
                    self?.newMovies = listOf.movies
                    completion()
                case .failure(let error):
                    // Something is wrong with the JSON
                    print("Error processing json data: \(error)")
            }
        }
    }
    
    func searchMovie(withQuery query: String, completion: @escaping () -> ()) {
        apiService.searchMovie(withquery: query) {
            [weak self] (result) in
            
            switch result {
                case .success(let listOf):
                    self?.newMovies = listOf.movies
                    completion()
                case .failure(let error):
                    // Something is wrong with the JSON
                    print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if newMovies.count != 0 {
            return newMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return newMovies[indexPath.row]
    }
    
   
}
