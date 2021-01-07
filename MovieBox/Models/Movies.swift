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
    let id: Int
    let title: String?
    let year: String?
    let rate: Double
    let posterImage: String?
    let overview: String?
    let language: String?
    private enum CodingKeys: String, CodingKey {
        case title, overview, id
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case language = "original_language"
    }
}
