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
    let resourceURL: URL

    init(movieID: Int) {
        let resourceString = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(TMDB_API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func fetchMovieItem(url: URL,completion: @escaping () -> ()){
        apiService.getMovieItem(url: url) { [weak self] (result) in
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
