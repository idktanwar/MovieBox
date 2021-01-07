//
//  Movies.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
////    let adult: Bool? = false
////    var id: Int?
//    let originalTitle:  String?
//    let releaseDate: String?
////    var title: String?
//    let voteAverage: Float?
    
    
////    let id: Int
//    let title: String
////    let backdropPath: String?
////    let posterPath: String?
////    let overview: String
//    let voteAverage: Double
////    let voteCount: Int
////    let runtime: Int?
//    let releaseDate: String
    
    
    let title: String?
    let year: String?
    let rate: Double
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}
