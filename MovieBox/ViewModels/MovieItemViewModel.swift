//
//  MovieItemViewModel.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 09/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

class MovieItemViewModel {
    
    private var movieItem: MovieItem!

    private var apiService = WebService()

    func fetchMovieItem(fromMovieId id: Int,completion: @escaping () -> ()){
        apiService.getMovieItem(fromMovieId: id) { [weak self] (result) in
            switch result {
            case .success(let movieItem):
                self?.movieItem = movieItem
                completion()
            case .failure(let error):
            // Something is wrong with the JSON
            print("Error processing json data: \(error)")
            }
        }
    }
    
}

extension MovieItemViewModel {
    
    var title: String {
        return self.movieItem.title ?? "Unavailable"
    }
    
    var language: String {
        return self.movieItem.language ?? ""
    }
    
    var movieTime: String {
        let str = "\(self.movieItem.runtime) Minutes"
        return str
    }
    
    var genre: String {
        var genreStr = ""
        if self.movieItem.genres.count > 0 {
            for genre in self.movieItem.genres{
                genreStr = genreStr + "| \(genre.name) "
            }
        }
        return String(genreStr.dropFirst())
    }
    
    var synopsis: String {
        return self.movieItem.overview ?? "Unavailable"
    }
    
    var releasedate: String {
        return self.movieItem.year ?? "Unavailable"
    }
    
    var posterPath: String {
        return self.movieItem.posterImage ?? ""
    }
}
