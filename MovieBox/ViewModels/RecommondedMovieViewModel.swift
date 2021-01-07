//
//  RecommondedMovieViewModel.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

class RecommondedMovieViewModel {
    
    private var apiService = WebService()
    private var recommonedMoviesList = [KindMovie]()
    
    func fetchSimilarMoviesData(forMovieId: Int, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getSimilarMoviesData(forMovieId: forMovieId) { [weak self] (result) in
            
            switch result {
                case .success(let listOf):
                    self?.recommonedMoviesList = listOf.recommondedMovies
                    completion()
                case .failure(let error):
                    // Something is wrong with the JSON
                    print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if recommonedMoviesList.count != 0 {
            return recommonedMoviesList.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> KindMovie {
        return recommonedMoviesList[indexPath.row]
    }
}
