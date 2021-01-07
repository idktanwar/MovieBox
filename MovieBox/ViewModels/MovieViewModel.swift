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
    
    func fetchNewMoviesData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getNewMoviesData { [weak self] (result) in
            
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

//struct MovieListViewModel {
//    let movies: [Movie]
//}
//
//extension MovieListViewModel {
//
//    var numberOfSections: Int {
//        return 1
//    }
//
//    func numberOfRowsInSection(_ section: Int) -> Int {
//        return self.movies.count
//    }
//
//    func movieAtIndex(_ index: Int) -> MovieViewModel {
//        let movie = self.movies[index]
//        return MovieViewModel(movie)
//    }
//
//}
//
//struct MovieViewModel {
//    private let movie: Movie
//}
//
//extension MovieViewModel {
//    init(_ movie: Movie) {
//        self.movie = movie
//    }
//}
//
//extension MovieViewModel {
//
////    var isadult: Bool {
////        return self.movie.adult ?? false
////    }
//
//    var title: String {
//        return self.movie.title ?? "Unavailable"
//    }
//
//    var rating: Double {
//        return self.movie.rate
//    }
//
//    var releaseDate: String {
//        return self.movie.year ?? "Unavailable"
//    }
//
//}
